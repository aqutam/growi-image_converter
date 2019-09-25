# frozen_string_literal: true

# img.esa.io の画像を GROWI にアタッチし直すクラス
class ImageConverter
  def initialize(client)
    @client = client
  end

  def convert(dry_run: true)
    get_pages.data.each do |page_summary|
      page_id = page_summary._id
      grant = page_summary.grant
      revision_id = page_summary.revision._id

      attached_files = []
      body = get_page(page_id).data.revision.body
      Dir.mktmpdir do |tempdir|
        scan_markdown_image_esa(body).each do |markdown_image|
          image_file = get_image_from_esa markdown_image, tempdir
          next if image_file.nil?

          api_return_attached_file = attach_file page_id, image_file, dry_run: dry_run
          if api_return_attached_file.ok
            attached_files.push(AttachedImageFile.new(markdown_image, api_return_attached_file))
          end
        end

        replaced_body = replace_markdown_image(body, attached_files)
        update_page page_id, revision_id, replaced_body, grant, dry_run: dry_run
      end
    end
  end

  private

  def get_pages(path_exp = '/')
    req = GApiRequestPagesList.new path_exp: path_exp
    @client.request(req)

    # TODO: レスポンスがNGだった場合raise
  end

  def get_page(page_id)
    req = GApiRequestPagesGet.new page_id: page_id
    @client.request(req)
  end

  def attach_file(page_id, file, dry_run: true)
    print page_id, ' ', file, "\n"
    return GApiReturn.new(ok: false, data: nil) if dry_run

    req = GApiRequestAttachmentsAdd.new page_id: page_id, file: file
    @client.request(req)
  end

  def update_page(page_id, revision_id, body, grant, dry_run: true)
    return if dry_run

    req = GApiRequestPagesUpdate.new page_id: page_id, revision_id: revision_id, body: body, grant: grant
    @client.request(req)
  end

  def scan_markdown_image_esa(body)
    markdown_images = []
    markdown_images.push(scan_markdown_image_inline_style(body))
    markdown_images.push(scan_markdown_image_reference_style(body))
  end

  def scan_markdown_image_inline_style(body)
    matches = body.scan(%r{!\[.*?\]\(\s*?https?://img.esa.io/.*?(?:\s+?".*?"\s*?)?\)})
    matches.map { |match| MarkdownImageInlineStyle.new match }
  end

  def scan_markdown_image_reference_style(body)
    matches = body.scan(%r{\[.*?\]: https?://img.esa.io/.*?(?: ".*?")?})
    matches.map { |match| MarkdownImageReferenceStyle.new match }
  end

  def scan_markdown_image_html_tag_style; end

  def get_image_from_esa(markdown_image, tempdir)
    tmp_file = URI.parse(markdown_image.url).open
    image_file = File.open(tempdir + '/' + File.basename(URI.parse(markdown_image.url).path), 'w+b')
    image_file.write(tmp_file.read)
    image_file.rewind
    image_file
  rescue StandardError => e
    print markdown_image.url, ': ', e, "\n"
    nil
  end

  def replace_markdown_image(body, attached_files)
    attached_files.each do |attached_file|
      attached_file_path = '/attachment/' + attached_file.api_return_attached_file.data[:attachment]._id
      replace = format(
        '%<syntax>s![%<alt_text>s](%<file_path>s)',
        syntax: attached_file.markdown_image.syntax,
        alt_text: attached_file.markdown_image.alt_text,
        file_path: attached_file_path
      )
      body.sub! attached_file.markdown_image.syntax, replace
    end
    body
  end
end

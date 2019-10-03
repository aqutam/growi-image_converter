# frozen_string_literal: true

module Growi
  module ImageConverter
    # page を扱うクラス
    class Page
      def initialize(page_id, client, dry_run: true)
        @dry_run = dry_run
        @client = client
        @api_return_page = get(page_id)
        @body = Body.new(api_return_page.data.revision.body)
        @attached_files = []
      end
      attr_accessor :api_return_page, :body, :attached_files

      def get(page_id)
        req = GApiRequestPagesGet.new page_id: page_id
        @client.request(req)
      end

      def replace_markdown_image
        attached_files.each { |attached_file| body.replace_markdown_image(attached_file) }
      end

      def attach_files(markdown_images, tempdir)
        markdown_images.each do |markdown_image|
          image_file = Growi::ImageConverter::Esa.get_image_from_esa markdown_image.url, tempdir
          next if image_file.nil?

          api_return_attached_file = attach_file image_file
          if api_return_attached_file.ok
            attached_files.push(Growi::ImageConverter::AttachedImageFile.new(markdown_image, api_return_attached_file))
          end
        end
      end

      def attach_file(file)
        page_id = api_return_page.data._id
        print page_id, ' ', file, "\n"
        return GApiReturn.new(ok: false, data: nil) if @dry_run

        req = GApiRequestAttachmentsAdd.new page_id: page_id, file: file
        @client.request(req)
      end

      def update
        ## TODO: 1つも更新対象がないとき、updateしない
        return if @dry_run

        page_id = api_return_page.data._id
        grant = api_return_page.data.grant
        revision_id = api_return_page.data.revision._id

        req = GApiRequestPagesUpdate.new page_id: page_id, revision_id: revision_id, body: body, grant: grant
        @client.request(req)
      end
    end
  end
end

# frozen_string_literal: true

module Growi
  module ImageConverter
    # img.esa.io の画像を GROWI にアタッチし直すクラス
    class Esa
      class << self
        def get_image_from_esa(url, tempdir)
          tmp_file = URI.parse(url).open
          image_file = File.open(tempdir + '/' + File.basename(URI.parse(url).path), 'w+b')
          image_file.write(tmp_file.read)
          image_file.rewind
          image_file
        rescue StandardError => e
          print url, ': ', e, "\n"
          nil
        end
      end

      def initialize(client)
        @client = client
      end

      def convert(dry_run: true)
        get_pages.data.each do |page_summary|
          Dir.mktmpdir do |tempdir|
            page = Growi::ImageConverter::Page.new(page_summary._id, @client, dry_run: dry_run)
            markdown_images = page.body.scan_markdown_image_esa
            page.attach_files(markdown_images, tempdir)
            page.replace_markdown_image
            page.update
            exit
          end
        end
      end

      private

      def get_pages(path_exp = '/')
        req = GApiRequestPagesList.new path_exp: path_exp
        @client.request(req)

        # TODO: レスポンスがNGだった場合raise
      end
    end
  end
end

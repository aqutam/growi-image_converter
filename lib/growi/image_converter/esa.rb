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
        end
      end

      def initialize(client)
        @client = client
      end

      def convert(dry_run: true)
        Signal.trap(:INT) { throw :exit_convert }
        catch :exit_convert do
          begin
            page_list = get_page_list
          rescue StandardError => e
            puts 'Error: ' + e.message
            exit 1
          end

          page_list.each do |page_summary|
            Dir.mktmpdir do |tempdir|
              begin
                page = Growi::ImageConverter::Page.new(page_summary._id, @client, dry_run: dry_run)
                page.body.scan_markdown_image_esa
                page.attach_files(page.body.group_by_url, tempdir)
                page.replace_markdown_image
                page.update
              rescue StandardError => e
                puts 'PageID: ' + page_summary._id + ', Result: Failed to convert' + ', Message: ' + e.message
                next
              end
            end
          end
        end
      end

      private

      def get_page_list(path_exp = '/')
        req = GApiRequestPagesList.new path_exp: path_exp
        api_return = @client.request(req)

        raise StandardError, 'Failed to get page list.' unless api_return.ok

        api_return.data
      end
    end
  end
end

# frozen_string_literal: true

module Growi
  module ImageConverter
    # page を扱うクラス
    class Page
      def initialize(page_id, client, dry_run: true)
        @dry_run = dry_run
        @client = client
        @data = get(page_id)
        @body = Body.new(data.revision.body)
        @attached_files = []
      end
      attr_accessor :data, :body, :attached_files

      def get(page_id)
        req = GApiRequestPagesGet.new page_id: page_id
        api_return = @client.request(req)

        raise StandardError, 'Failed to get page data.' unless api_return.ok

        api_return.data
      end

      def attach_files(markdown_images, tempdir)
        markdown_images.each do |markdown_image|
          begin
            image_file = Growi::ImageConverter::Esa.get_image_from_esa markdown_image.url, tempdir
            attached_file = attach_file image_file
            unless attached_file.nil?
              attached_files.push(Growi::ImageConverter::AttachedImageFile.new(markdown_image, attached_file))
            end
          rescue StandardError => e
            puts 'PageID: ' + data._id + ', Image URL: ' + markdown_image.url + ', Message: ' + e.message
            next
          end
        end
      end

      def attach_file(file)
        return nil if @dry_run

        req = GApiRequestAttachmentsAdd.new page_id: data._id, file: file
        api_return = @client.request(req)

        raise StandardError, 'Failed to atach file.' unless api_return.ok

        api_return.data
      end

      def replace_markdown_image
        attached_files.each { |attached_file| body.replace_markdown_image(attached_file) }
      end

      def update
        # TODO: 1つも更新対象がないとき、updateしない

        unless @dry_run
          req = GApiRequestPagesUpdate.new(
            page_id: data._id,
            revision_id: data.revision._id,
            body: body,
            grant: data.grant
          )
          api_return = @client.request(req)

          raise StandardError, 'Failed to update page.' unless api_return.ok
        end

        puts 'PageID: ' + data._id + ', Result: Converted'
      end
    end
  end
end

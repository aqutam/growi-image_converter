# frozen_string_literal: true

module Growi
  module ImageConverter
    # Image Markdownとアタッチされた画像を対応させるクラス
    class AttachedImageFile
      def initialize(markdown_images, attached_file)
        @data = attached_file
        @markdown_images = markdown_images
      end
      attr_accessor :data, :markdown_images
    end
  end
end

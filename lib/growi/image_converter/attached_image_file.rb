# frozen_string_literal: true

module Growi
  module ImageConverter
    # Image Markdownとアタッチされた画像を対応させるクラス
    class AttachedImageFile
      def initialize(markdown_image, attached_file)
        @markdown_image = markdown_image
        @data = attached_file
      end
      attr_accessor :markdown_image, :data
    end
  end
end

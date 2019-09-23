# frozen_string_literal: true

# Image Markdownとアタッチされた画像を対応させるクラス
class AttachedImageFile
  def initialize(markdown_image, api_return_attached_file)
    @markdown_image = markdown_image
    @api_return_attached_file = api_return_attached_file
  end
  attr_accessor :markdown_image, :api_return_attached_file
end

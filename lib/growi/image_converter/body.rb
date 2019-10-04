# frozen_string_literal: true

module Growi
  module ImageConverter
    # markdown bodyを扱うクラス
    class Body
      REGEX_SPACE = '[ \t]'
      REGEX_URL_PREFIX_ESA = 'https?://img.esa.io/'
      REGEX_SPACE_OR_RETURN = "(?:#{REGEX_SPACE}*?\\n)?#{REGEX_SPACE}*?"
      REGEX_SPACE_GE_1_OR_RETURN = "(?:#{REGEX_SPACE}+?|#{REGEX_SPACE_OR_RETURN})"
      REGEX_TITLE = "(?:#{REGEX_SPACE_GE_1_OR_RETURN}\".*?\")?"

      FILE_PATH_PREFIX = '/attachment/'

      def initialize(body)
        @body = body
      end
      attr_accessor :body

      def scan_markdown_image_esa
        matches = []

        # Image syntax inline
        matches.concat(body.scan(
                         /
                         !\[#{REGEX_SPACE_OR_RETURN}.*?#{REGEX_SPACE_OR_RETURN}\]
                         \(#{REGEX_SPACE_OR_RETURN}
                         #{REGEX_URL_PREFIX_ESA}.*?#{REGEX_TITLE}
                         #{REGEX_SPACE_OR_RETURN}\)
                         /x
                       ))

        # Image syntax reference-style
        matches.concat(body.scan(
                         /
                         \[#{REGEX_SPACE_OR_RETURN}.*?#{REGEX_SPACE_OR_RETURN}\]:
                         #{REGEX_SPACE_OR_RETURN}#{REGEX_URL_PREFIX_ESA}.*
                         /x
                       ))

        # Image syntax img tag
        matches.concat(body.scan(/<img#{REGEX_SPACE_GE_1_OR_RETURN}.*?#{REGEX_URL_PREFIX_ESA}.*?>/m))

        matches.map { |match| Growi::ImageConverter::MarkdownImage.new match }
      end

      def replace_markdown_image(attached_file)
        attached_file_path = FILE_PATH_PREFIX + attached_file.data[:attachment]._id
        attached_file.markdown_images.each do |markdown_image|
          body.sub! markdown_image.syntax, markdown_image.replace_url(attached_file_path)
        end
      end
    end
  end
end

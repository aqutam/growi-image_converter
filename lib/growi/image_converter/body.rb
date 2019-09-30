# frozen_string_literal: true

module Growi
  module ImageConverter
    # markdown bodyを扱うクラス
    class Body
      REGEX_URL_PREFIX_ESA = 'https?://img.esa.io/'
      REGEX_SPACE_GE_1_OR_RETURN = '(?:\s+?|\n)'
      REGEX_SPACE_OR_RETURN = '(?:\s*?\n)?\s*?'
      REGEX_TITLE = "(?:#{REGEX_SPACE_GE_1_OR_RETURN}\".*?\")?"

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
                         #{REGEX_URL_PREFIX_ESA}.*?\s*?#{REGEX_TITLE}
                         #{REGEX_SPACE_OR_RETURN}\)
                         /x
                       ))

        # Image syntax reference-style
        matches.concat(body.scan(
                         /
                         \[#{REGEX_SPACE_OR_RETURN}.*?#{REGEX_SPACE_OR_RETURN}\]:\s*?#{REGEX_URL_PREFIX_ESA}.*
                         /x
                       ))

        # Image syntax img tag
        matches.concat(body.scan(/<img#{REGEX_SPACE_GE_1_OR_RETURN}.*?#{REGEX_URL_PREFIX_ESA}.*?>/m))

        matches.map { |match| Growi::ImageConverter::MarkdownImage.new match }
      end

      def replace_markdown_image(attached_files)
        attached_files.each do |attached_file|
          attached_file_path = '/attachment/' + attached_file.api_return_attached_file.data[:attachment]._id
          body.sub! attached_file.markdown_image.url, attached_file_path
        end
        body
      end
    end
  end
end

# frozen_string_literal: true

module Growi
  module ImageConverter
    # Markdown syntax image
    class MarkdownImage
      def initialize(syntax)
        match = syntax.match(%r{(?<url>https?://.*?)(?:\s+?|"|\)|$)})

        @syntax = syntax
        @url = match&.[](:url)
      end
      attr_accessor :syntax, :url

      def replace_url(new_url)
        syntax.sub url, new_url
      end
    end
  end
end

# frozen_string_literal: true

# Markdown syntax image
class MarkdownImageInlineStyle
  def initialize(syntax)
    match = syntax.match(%r{!\[(?<alt_text>.*?)\]\(\s*?(?<url>https?://img.esa.io/.*?)(?:\s+?"(?<title>.*?)"\s*?)?\)})

    @syntax = syntax
    @alt_text = match[:alt_text]
    @url = match[:url]
    @title = match[:title]
  end
  attr_accessor :syntax, :alt_text, :url, :title
end

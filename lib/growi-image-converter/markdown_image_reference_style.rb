# frozen_string_literal: true

# Markdown syntax image
class MarkdownImageReferenceStyle
  def initialize(syntax)
    match = syntax.match(%r{\[(?<id>.*?)\]: (?<url>https?://img.esa.io/.*?)(?: "(?<title>.*?)")?})

    @syntax = syntax
    @id = match[:id]
    @url = match[:url]
    @title = match[:title]
  end
  attr_accessor :syntax, :id, :url, :title
end

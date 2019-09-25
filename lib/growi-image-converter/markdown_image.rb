# frozen_string_literal: true

# Markdown syntax image
class MarkdownImage
  def initialize(syntax)
    match = syntax.match(%r{(?<url>https?://.*?)(?:\s+?|\n|"|\))})

    @syntax = syntax
    @url = match&.[](:url)
  end
  attr_accessor :syntax, :url
end

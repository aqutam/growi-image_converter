# frozen_string_literal: true

# Markdown syntax image
class MarkdownImage
  def initialize(syntax)
    @syntax, @alt_text, @url = syntax.match(%r{!\[(.+?)\]\((https?://img.esa.io/.+?)\)}).to_a
  end
  attr_accessor :syntax, :alt_text, :url
end

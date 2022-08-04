# frozen_string_literal: true

require_relative 'validators/page_view_validator'

class PageView
  class FileSyntaxError < StandardError; end

  attr_reader :url, :ip

  def initialize(page_view_string)
    @url, @ip = page_view_string.split

    validate_page_view
  end

  private

  def validate_page_view
    raise FileSyntaxError, 'Your file is invalid.' unless ::Validators::PageViewValidator.new.valid?(self)
  end
end

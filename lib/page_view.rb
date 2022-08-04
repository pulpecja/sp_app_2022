# frozen_string_literal: true

require_relative 'validators/page_view_validator'

class PageView
  class FileSyntaxError < StandardError; end

  attr_reader :url, :ip

  def initialize(page_view_string)
    @url, @ip = page_view_string.split
  end

  def valid?
    Validators::PageViewValidator.new.valid?(self)
  end
end

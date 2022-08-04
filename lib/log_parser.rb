# frozen_string_literal: true

class LogParser
  require_relative 'page_view'
  require_relative 'validators/file_name_validator'
  require 'pry'

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    validate_file
  end

  private

  def validate_file
    unless Validators::FileNameValidator.new.file_name_exists?(@file_name)
      raise ArgumentError,
            'Try again, but this time give me a file name, please.'
    end
    raise ArgumentError, 'This file does not exist.' unless Validators::FileNameValidator.new.file_exists?(@file_name)
  end
end

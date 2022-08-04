# frozen_string_literal: true

module Validators
  class FileNameValidator
    def file_name_exists?(file_name)
      return false if file_name.nil?

      !file_name.empty?
    end

    def file_exists?(file_name)
      File.exist?(file_name)
    end
  end
end

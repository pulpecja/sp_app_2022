# frozen_string_literal: true

class LogParser
  require_relative 'page_view'
  require_relative 'page_views_counter'
  require_relative 'validators/file_name_validator'
  require_relative 'presenters/page_views_counter_presenter'

  class FileSyntaxError < StandardError; end

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    validate_file
    counter = PageViewsCounter.new

    File.open(@file_name).each do |line|
      page_view = PageView.new(line)
      raise FileSyntaxError, 'File is invalid.' unless page_view.valid?

      counter.add_page_visit(page_view)
    end

    print_output(counter)
  end

  private

  def print_output(counter)
    presenter = PageViewsCounterPresenter.new(counter)
    presenter.most_page_views
    presenter.empty_line
    presenter.most_unique_page_views
  end

  def validate_file
    unless Validators::FileNameValidator.new.file_name_exists?(@file_name)
      raise ArgumentError,
            'Try again, but this time give me a file name, please.'
    end
    raise ArgumentError, 'This file does not exist.' unless Validators::FileNameValidator.new.file_exists?(@file_name)
  end
end

# frozen_string_literal: true

class PageViewsCounterPresenter
  attr_reader :counter

  def initialize(counter)
    @counter = counter
  end

  def most_page_views
    puts 'Most page views:'

    views = count_most_page_views(counter.pages_views)
    print_output(views)
  end

  def most_unique_page_views
    puts 'Most unique page views:'

    views = count_most_unique_page_views(counter.pages_views)
    print_output(views)
  end

  private

  def count_most_page_views(pages_views)
    most_page_views = pages_views.transform_values(&:count)
    sort_list_descending(most_page_views)
  end

  def count_most_unique_page_views(pages_views)
    most_uniq_page_views = pages_views.transform_values do |v|
      v.uniq.count
    end
    sort_list_descending(most_uniq_page_views)
  end

  def sort_list_descending(list)
    list.sort_by { |_key, value| value }.reverse
  end

  def print_output(views)
    views.each { |page| puts "#{page.join(' ')} #{noun(page)}" }
  end

  def noun(page)
    return 'visit' if page[1] == 1

    'visits'
  end
end

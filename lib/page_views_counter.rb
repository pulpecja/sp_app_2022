# frozen_string_literal: true

class PageViewsCounter
  attr_reader :pages_views

  def initialize
    @pages_views = {}
  end

  def add_page_visit(page_view)
    if @pages_views[page_view.url].nil?
      create_page(page_view)
    else
      add_visit(page_view)
    end
  end

  private

  def create_page(page)
    @pages_views[page.url] = [page.ip]
  end

  def add_visit(page_view)
    @pages_views[page_view.url] << page_view.ip
  end
end

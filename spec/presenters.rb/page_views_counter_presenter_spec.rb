# frozen_string_literal: true

require 'spec_helper'

describe PageViewsCounterPresenter do
  let(:presenter) { described_class.new(counter) }
  let(:counter) { PageViewsCounter.new }

  let(:page_view1) { PageView.new('/contact 184.123.665.109') }
  let(:page_view2) { PageView.new('/help_page/1 126.318.035.038') }
  let(:page_view3) { PageView.new('/contact 184.123.665.067') }

  before do
    counter.add_page_visit(page_view1)
    counter.add_page_visit(page_view2)
    counter.add_page_visit(page_view3)
    counter.add_page_visit(page_view1)
  end

  describe '#most_page_views' do
    subject(:most_page_views) { presenter.most_page_views }

    let(:expected_output) do
      <<~HEREDOC
        Most page views:
        /contact 3 visits
        /help_page/1 1 visit
      HEREDOC
    end

    it 'prints list of most page views' do
      expect { most_page_views }.to output(expected_output).to_stdout
    end
  end

  describe '#most_unique_page_views' do
    subject(:most_unique_page_views) { presenter.most_unique_page_views }

    let(:expected_output) do
      <<~HEREDOC
        Most unique page views:
        /contact 2 visits
        /help_page/1 1 visit
      HEREDOC
    end

    it 'prints list of most unique page views' do
      expect { most_unique_page_views }.to output(expected_output).to_stdout
    end
  end

  describe '#empty_line' do
    subject(:empty_line) { presenter.empty_line }

    it 'prints empty line' do
      expect { empty_line }.to output("\n").to_stdout
    end
  end
end

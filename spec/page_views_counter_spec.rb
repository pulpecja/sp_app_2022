# frozen_string_literal: true

require 'spec_helper'

describe PageViewsCounter do
  describe '#add_page_visit' do
    subject(:add_page_visit) { page_views_counter.add_page_visit(page_view) }

    let(:page_views_counter) { described_class.new }
    let(:page_view1) { PageView.new('/contact 184.123.665.109') }
    let(:page_view2) { PageView.new('/help_page/1 126.318.035.038') }
    let(:page_view3) { PageView.new('/contact 184.123.665.067') }

    it 'creates new pages and adds ips to pages_views attribute' do
      page_views_counter.add_page_visit(page_view1)
      expect(page_views_counter.pages_views).to eq({ '/contact' => ['184.123.665.109'] })
      page_views_counter.add_page_visit(page_view2)
      page_views_counter.add_page_visit(page_view3)
      page_views_counter.add_page_visit(page_view1)
      expect(page_views_counter.pages_views).to eq({
                                                     '/contact' => ['184.123.665.109', '184.123.665.067',
                                                                    '184.123.665.109'],
                                                     '/help_page/1' => ['126.318.035.038']
                                                   })
    end
  end
end

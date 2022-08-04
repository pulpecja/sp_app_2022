# frozen_string_literal: true

require 'spec_helper'

describe PageView do
  describe '#initialize' do
    subject(:page_view) { described_class.new(page_view_string) }

    context 'with valid page_view_string' do
      let(:page_view_string) { '/help_page/1 126.318.035.038' }

      it 'creates Page View with valid attributes' do
        expect(page_view.url).to eq '/help_page/1'
        expect(page_view.ip).to eq '126.318.035.038'
      end
    end
  end

  describe '#valid?' do
    subject { described_class.new('page_view').valid? }

    before do
      allow(Validators::PageViewValidator)
        .to receive_message_chain(:new, :valid?)
        .and_return(page_view_validity)
    end

    context 'for valid validator response' do
      let(:page_view_validity) { true }

      it { is_expected.to be true }
    end

    context 'for valid validator response' do
      let(:page_view_validity) { false }

      it { is_expected.to be false }
    end
  end
end

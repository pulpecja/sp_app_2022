# frozen_string_literal: true

require 'spec_helper'

describe Validators::PageViewValidator do
  describe '#valid?' do
    subject { described_class.new.valid?(page_view) }

    let(:page_view) { PageView.new(line) }

    context 'for valid page_view' do
      let(:line) { '/help_page/1 126.318.035.038' }

      it { is_expected.to be true }
    end

    context 'for invalid url' do
      let(:line) { 'I am not url 126.318.035.038' }

      it { is_expected.to be false }
    end

    context 'for invalid ip' do
      let(:line) { '/help_page/1 I am not IP' }

      it { is_expected.to be false }
    end

    context 'for completely invalid page_view' do
      let(:line) { 'I am so invalid' }

      it { is_expected.to be false }
    end
  end
end

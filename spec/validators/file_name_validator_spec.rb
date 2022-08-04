# frozen_string_literal: true

require 'spec_helper'

describe Validators::FileNameValidator do
  describe '#file_name_exists?' do
    subject { described_class.new.file_name_exists?(file_name) }

    context 'for nil file name' do
      let(:file_name) { nil }

      it { is_expected.to be false }
    end

    context 'for empty file name' do
      let(:file_name) { '' }

      it { is_expected.to be false }
    end

    context 'for valid file name' do
      let(:file_name) { 'spec/data/invalid_webserver.log' }

      it { is_expected.to be true }
    end
  end

  describe '#file_exists?' do
    subject { described_class.new.file_exists?(file_name) }

    context 'for invalid file name' do
      let(:file_name) { 'non_existing' }

      it { is_expected.to be false }
    end

    context 'for valid file name' do
      let(:file_name) { 'spec/data/invalid_webserver.log' }

      it { is_expected.to be true }
    end
  end
end

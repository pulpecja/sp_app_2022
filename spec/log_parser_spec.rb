# frozen_string_literal: true

require 'spec_helper'

describe LogParser do
  describe '#call' do
    subject(:call) { described_class.new(file_name).call }

    let(:file_name) { 'file_name' }
    let(:file_existence) { true }
    let(:file_name_existence) { true }

    shared_examples 'raises ArgumentError with message' do
      it 'raises ArgumentError' do
        expect { call }.to raise_error(ArgumentError, error_message)
      end
    end

    before do
      allow(Validators::FileNameValidator)
        .to receive_message_chain(:new, :file_exists?)
        .with(file_name)
        .and_return(file_existence)
      allow(Validators::FileNameValidator)
        .to receive_message_chain(:new, :file_name_exists?)
        .with(file_name)
        .and_return(file_name_existence)
    end

    context 'for invalid file name' do
      let(:file_existence) { true }
      let(:file_name_existence) { false }
      let(:error_message) { 'Try again, but this time give me a file name, please.' }

      include_examples 'raises ArgumentError with message'
    end

    context 'for valid, but non-existing file name' do
      let(:file_existence) { false }
      let(:file_name_existence) { true }
      let(:error_message) { 'This file does not exist.' }

      include_examples 'raises ArgumentError with message'
    end
  end
end

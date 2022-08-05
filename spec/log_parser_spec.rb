# frozen_string_literal: true

require 'spec_helper'

describe LogParser do
  describe '#call' do
    subject(:call) { described_class.new(file_name).call }

    let(:file_name) { 'file_name' }
    let(:file_existence) { true }
    let(:file_name_existence) { true }
    let(:validator) { Validators::FileNameValidator }

    shared_examples 'raises ArgumentError with message' do
      it 'raises ArgumentError' do
        expect { call }.to raise_error(ArgumentError, error_message)
      end
    end

    before do
      double = instance_double(validator)
      allow(validator).to receive(:new).and_return(double)
      allow(double).to receive(:file_exists?).with(file_name).and_return(file_existence)
      allow(double).to receive(:file_name_exists?).with(file_name).and_return(file_name_existence)
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

    context 'for invalid file syntax' do
      let(:file_name) { 'spec/data/invalid_webserver.log' }

      it 'raises FileSyntaxError' do
        expect { call }.to raise_error(LogParser::FileSyntaxError, 'File is invalid.')
      end
    end

    context 'for valid file' do
      let(:file_name) { 'spec/data/valid_webserver.log' }
      let(:expected_output) do
        <<~HEREDOC
          Most page views:
          /contact 4 visits
          /home 1 visit
          /help_page/1 1 visit

          Most unique page views:
          /contact 2 visits
          /home 1 visit
          /help_page/1 1 visit
        HEREDOC
      end

      it 'does not raise any errors' do
        expect { call }.not_to raise_error
      end

      it 'prints output' do
        expect { call }.to output(expected_output).to_stdout
      end
    end
  end
end

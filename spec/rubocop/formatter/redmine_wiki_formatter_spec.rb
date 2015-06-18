# encoding: utf-8

require 'spec_helper'
require 'stringio'
require 'fileutils'

module RuboCop
  module Formatter
    describe RedmineWikiFormatter do
      subject(:formatter) { described_class.new(output) }
      let(:output) { StringIO.new }

      describe '#report_file' do
        before do
          formatter.report_file(file, [offense])
        end

        let(:file) { '/path/to/file' }

        let(:offense) do
          Cop::Offense.new(:convention, location,
                           'This is a message.', 'CopName', status)
        end

        let(:location) do
          source_buffer = Parser::Source::Buffer.new('test', 1)
          source_buffer.source = "a\n"
          Parser::Source::Range.new(source_buffer, 0, 1)
        end

        let(:status) { :uncorrected }

        context 'the file is under the current working directory' do
          let(:file) { File.expand_path('spec/spec_helper.rb') }

          it 'prints as relative path' do
            expect(output.string).to include('h2. spec/spec_helper.rb ')
          end
        end

        context 'the file is outside of the current working directory' do
          let(:file) do
            tempfile = Tempfile.new('')
            tempfile.close
            File.expand_path(tempfile.path)
          end

          it 'prints as absolute path' do
            expect(output.string).to include("h2. #{file} ")
          end
        end

        context 'when the offense is not corrected' do
          let(:status) { :uncorrected }

          it 'prints message as-is' do
            expect(output.string)
              .to include('This is a message.')
          end
        end

        context 'when the offense is automatically corrected' do
          let(:status) { :corrected }

          it 'prints [Corrected] along with message' do
            expect(output.string)
              .to include('[Corrected] This is a message.')
          end
        end
      end

    end
  end
end

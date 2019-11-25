require 'rails_helper'
require "#{Rails.root}/app/models/modules/csv_parser.rb"

class DummyClass
  include CsvParser
end

RSpec.describe CsvParser do
  let(:target) { DummyClass.new }

  describe '#import' do
    subject { target.import(file) }

    context 'properly formed csv' do
      let(:file) { file_fixture("sample.csv") }
      let(:csv_headers) { CSV.open(file, &:readline) }

      it 'returns an OpenStruct object' do
        expect(subject).to be_an(OpenStruct)
      end

      it 'responds to headers, rows and footer' do
        expect(subject).to respond_to(:headers)
        expect(subject).to respond_to(:rows)
        expect(subject).to respond_to(:footer)
      end

      it 'has headers contained in an array' do
        expect(subject.headers).to be_an(Array)
      end

      it 'snake_cases all headers' do
        snake_cased = csv_headers.map { |h| h.strip.gsub(' ', '_') }
        expect(subject.headers).to eq(snake_cased)
      end

      it 'has rows contained as hashes in an array' do
        expect(subject.rows).to be_an(Array)
        expect(subject.rows).to all( be_a(Hash) )
      end

      it 'has a footer contained in a hash' do
        expect(subject.footer).to be_a(Hash)
      end
    end
  end
end

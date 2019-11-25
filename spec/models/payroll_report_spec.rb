require 'rails_helper'

RSpec.describe PayrollReport, type: :model do

  let(:target) { described_class.new(time_entries: time_entries) }

  describe '#generate_report' do
    subject { target.generate_report }

    context 'when time entries exist' do
      let(:employee_ids) { [1, 2, 3, 4] }

      let(:time_entries) do
        employee_ids.map do |id|
          [id, create_list(:time_entry, 4, employee_id: id)]
        end.to_h
      end

      it 'returns a multinested hash' do
        expect(subject).to be_a(Hash)
        expect(subject.values).to all( be_a(Hash) )
      end

      it 'is grouped by employee ids' do
        expect(subject.keys).to eq(employee_ids)
      end

      it 'is subsequently grouped by pay period' do
        subject.values.each do |item|
          expect(item.keys).to all( be_a(Range) )
          expect(item.values).to all( be_a(Float) )
        end
      end
    end

    context 'when time entries do not exist' do
      let(:time_entries) { {} }

      it 'returns an empty hash' do
        expect(subject).to be_a(Hash)
        expect(subject).to be_empty
      end
    end
  end
end

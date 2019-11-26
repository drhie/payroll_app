require 'rails_helper'

RSpec.describe TimeEntry, type: :model do
  describe '#total_pay' do
    let(:target) { described_class.new }

    subject { target.total_pay }

    let(:wage_rates) do
      { 'A' => 20.0, 'B' => 30.0 }
    end

    before do
      target.assign_attributes(hours_worked: 10)
    end

    context 'when job_group is valid' do
      it 'multiplies hours with job_group wage' do
        target.job_group = 'A'
        expect(subject).to eq(200.0)
      end
    end

    context 'when job_group is invalid' do
      it' does not add any calculation (0)' do
        target.job_group = 'C'
        expect(subject).to eq(0.0)
      end
    end
  end

  describe 'class methods' do
    before do
      create_list(:time_entry, 3, employee_id: '1')
      create_list(:time_entry, 3, employee_id: '2')
    end

    let(:employee_ids) { ['1', '2'] }

    describe '.employee_ids' do
      subject { described_class.employee_ids }

      it 'plucks all unique employee_ids' do
        expect(subject).to eq(employee_ids)
      end
    end

    describe '.grouped_by_employee_id' do
      subject { described_class.grouped_by_employee_id }

      it 'returns a hash' do
        expect(subject).to be_a(Hash)
      end

      it 'returns employee_ids as keys and an array as values' do
        expect(subject.keys).to eq(employee_ids)
        expect(subject.values).to be_an(Array)
      end

      it 'contains time entries within those array values' do
        expect(subject.values.flatten).to all( be_a_kind_of(TimeEntry) )
      end
    end
  end
end

require 'rails_helper'

RSpec.describe TimeReport, type: :model do
  let(:target) { described_class.new }

  describe '#store_report' do
    subject { target.store_report(file) }

    context 'when file is properly formed' do
      let(:file) { double('file') }
      let(:headers) { ["date", "hours_worked", "employee_id", "job_group"] }
      let(:rows) do
        [
          { date: '4/11/2016', hours_worked: '10', employee_id: '1', job_group: 'A' },
          { date: '14/11/2016', hours_worked: '5', employee_id: '1', job_group: 'A' },
          { date: '20/11/2016', hours_worked: '3', employee_id: '2', job_group: 'B' }
        ]
      end
      let(:footer) { { report_id: 'a1b2c3' } }

      let(:report) { OpenStruct.new({headers: headers, rows: rows, footer: footer}) }

      before do
        allow(target).to receive(:import).with(file).and_return(report)
      end

      context 'when it is sent once' do
        it 'updates its report_id with the footer value' do
          subject
          expect(target.report_id).to eq(footer[:report_id])
        end

        it 'archives all rows as time_entries' do
          subject
          expect(target.time_entries.length).to eq(rows.length)
        end
			end

      context 'when it is sent more than once' do
        before do
          duplicate = target.clone
          duplicate.store_report(file)
          duplicate.save
        end

        it 'does not save the subsequent time report' do
          subject
          expect(target.valid?).to be false
        end
			end
		end
  end
end

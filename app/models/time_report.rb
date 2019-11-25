require_relative 'modules/csv_parser.rb'

class TimeReport < ApplicationRecord
	has_many :time_entries
  validates_uniqueness_of :report_id

  include CsvParser

  def store_report(file)
    report = self.import(file)
    self.report_id = report.footer[:report_id]
    archive(report.rows)
  end

  private
  def archive(rows)
    time_entries.new(rows)
  end
end

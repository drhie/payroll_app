class PayrollReportsController < ApplicationController
  before_action :payroll_report

  def index
    @report = @payroll.generate_report
    render :index
  end

  private
  def payroll_report
    time_entries = TimeEntry.grouped_by_employee_id
    @payroll = PayrollReport.new(time_entries: time_entries)
  end
end

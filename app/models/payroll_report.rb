# NOTE TO FUTURE DEVELOPERS: This class is highly vulnerable to change based on future requirements.
# Due to a dependency injection upon initialization, it is closely coupled to the TimeEntry class.
# As there is no current requirement for multiple payroll reports, this class does not have a table.

class PayrollReport
  attr_accessor :time_entries

  def initialize(args)
    @time_entries = args[:time_entries]
  end

  def generate_report
    time_entries.map do |id, entries|
      [id, payroll(entries)]
    end.to_h.sort.to_h
  end

  private
  def mid_month(date)
    date.beginning_of_month + 14
  end

  def pay_period(date)
    date <= mid_month(date) ? first_half(date) : second_half(date)
  end

  def first_half(date)
    date.beginning_of_month .. date.beginning_of_month + 14
  end

  def second_half(date)
    date.beginning_of_month + 15 .. date.end_of_month
  end

  def payroll(entries)
    payroll = {}
    entries.each do |entry|
      period = pay_period(entry.date)
      payroll[period] = (payroll[period] || 0) + entry.total_pay
    end
    payroll
  end
end

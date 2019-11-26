##
# This class manages the individual entries of a time report.
class TimeEntry < ApplicationRecord
  belongs_to :time_report
  validates :date,
            :hours_worked,
            :employee_id,
            :job_group, presence: true

  def self.employee_ids
    pluck(:employee_id).uniq
  end

  def self.grouped_by_employee_id
    order(:date).group_by(&:employee_id)
  end

  def total_pay
    hours_worked * wage_rate
  end

  private
  # If a wage_rate can't be fetched, then don't include it in any calculations (0).
  def wage_rate
    wage_rates.fetch(job_group, 0)
  end

  # This hard-coded data is isolated here until we have more info in the future about jobs.
  def wage_rates
    {
      'A' => 20.0,
      'B' => 30.0
    }
  end
end

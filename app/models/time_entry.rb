class TimeEntry < ApplicationRecord
  belongs_to :time_report
  validates :date,
            :hours_worked,
            :employee_id,
            :job_group, presence: true

end

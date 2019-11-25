FactoryBot.define do
  factory :time_report do
    report_id { rand.to_s }
  end

  factory :time_entry do
    association :time_report

    date { '4/11/2016' }
    employee_id { '1' }
    hours_worked { 10 }
    job_group { 'A' }
  end
end

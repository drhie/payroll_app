module PayrollReportsHelper
  def report_table_contents(report)
    report.map do |employee_id, pay_details|
      pay_details.map do |period, amount_paid|
        {
          employee_id: employee_id,
          payment_period: "#{period.first.strftime('%-d/%m/%Y')} - #{period.last.strftime('%-d/%m/%Y')}",
          amount_paid: number_with_precision(amount_paid, precision: 2)
        }
      end
    end.flatten
  end
end

class CreateTimeReports < ActiveRecord::Migration[6.0]
  def change
    create_table :time_reports do |t|
      t.string :report_id, null: false

      t.timestamps
    end
  end
end

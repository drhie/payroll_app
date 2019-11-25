class CreateTimeEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :time_entries do |t|
      t.date :date, null: false
      t.integer :hours_worked, null: false
      t.string :employee_id, null: false
      t.string :job_group, null: false
      t.string :report_id, null: false
      t.references :time_report, foreign_key: true

      t.timestamps
    end
  end
end

class RemoveReportIdFromTimeEntry < ActiveRecord::Migration[6.0]
  def change
    remove_column :time_entries, :report_id, :string
  end
end

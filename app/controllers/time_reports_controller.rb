class TimeReportsController < ApplicationController
  def create
    time_report = TimeReport.new
    time_report.store_report(csv_file)
    if time_report.valid?
      time_report.save
      flash[:success] = "Your report has been saved!"
    else
      flash[:errors] = time_report.errors.full_messages
    end
    redirect_to root_url
  end

  private
  def time_report_params
    params.require(:time_report).permit(:csv_file)
  end

  def csv_file
    time_report_params[:csv_file]
  end
end

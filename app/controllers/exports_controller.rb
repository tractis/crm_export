class ExportsController < ApplicationController
  before_filter :require_user

  # Get /export
  # ------------------------------------------------------------------------------
  def index
    redirect_to :contacts
  end

  # Get /export
  # ------------------------------------------------------------------------------
  def contacts
    format = params[:id]

    if format == "csv"
      Delayed::Job.enqueue Export.new(@current_user)
      flash[:info] = t(:export_generation_message)
    else
      flash[:error] = t(:export_undefined_format)
    end

    redirect_to profile_path 
  end  

  # Get /download
  # ------------------------------------------------------------------------------
  def download
    format = params[:id]

    if format == "csv"
      send_file "#{RAILS_ROOT}/files/crm_export/csv/contacts_#{@current_user.id}.csv"
    end
  end 
  
end

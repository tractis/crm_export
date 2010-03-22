class ExportNotifier < ActionMailer::Base

  #----------------------------------------------------------------------------
  def notify_job(email)    
    I18n.locale = Setting.locale
    subject       "Fat Free CRM: " + I18n.t(:export_job_complete)
    from          "Fat Free CRM <noreply@fatfreecrm.com>"
    recipients    email
    sent_on       Time.now
    body          :email => email
  end

end
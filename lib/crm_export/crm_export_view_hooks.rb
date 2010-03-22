class CrmExportViewHooks < FatFreeCRM::Callback::Base
  
  PROFILE_SHOW = <<EOS
.subtitle= t :export
.section
  %li
    %tt= link_to(t(:to_csv, t(:contacts)), :controller => :exports, :action => :contacts, :id => :csv)
    - if File.exist? "#{RAILS_ROOT}/files/crm_export/csv/contacts_8.csv"
      %dt= link_to(t(:export_download, File.mtime("#{RAILS_ROOT}/files/crm_export/csv/contacts_8.csv")), :controller => :exports, :action => :download, :id => :csv)
    - else
      %dt= t(:export_no_files)
  -#%li
    -#%tt= link_to(t(:to_ldif, t(:contacts)), :controller => :exports, :action => :contacts, :id => :ldif)
EOS

  define_method :show_user_bottom do |view, context|
    Haml::Engine.new(PROFILE_SHOW).render(view)
  end
  
end

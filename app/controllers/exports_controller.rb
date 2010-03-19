class ExportsController < ApplicationController
  before_filter :require_user

  # Get /export
  # ------------------------------------------------------------------------------
  def index
    redirect_to :csv
  end

  # Get /export
  # ------------------------------------------------------------------------------
  def contacts
    format = params[:id]
    
    conditions = ["contacts.user_id=? OR contacts.assigned_to=? OR permissions.user_id=? OR access='Public'", @current_user]
    @contacts = Contact.my(:user => @current_user, :include => [:permissions, :comments, :account, :business_address], :conditions => conditions)
    @single_address_field = Setting.single_address_field
    
    unless @contacts.blank?
      if format == "csv"
        require "fastercsv"
        csv_string = FasterCSV.generate do |csv|
          csv << ["first_name", "last_name", "organization", "street1", "street2", "city", "state", "zipcode", "country", "title", "department", "email", "alt_email", "phone", "mobile", "fax", "blog", "linkedin", "facebook", "twitter", "birth_day", "notes"]        
          @contacts.each do |c|            
              comment = get_comment(c)
              organization = get_account(c.account)
              address = get_address(c.business_address)
              csv << [c.first_name, c.last_name, organization, address["street1"], address["street2"], address["city"], address["state"], address["zipcode"], address["country"], c.title, c.department, c.email, c.alt_email, c.phone, c.mobile, c.fax, c.blog, c.linkedin, c.facebook, c.twitter, c.born_on, comment]
          end
        end
        if format == "csv"
          send_data csv_string, :type => "text/plain", :filename=>"contacts.csv", :disposition => 'attachment'
        end        
      end
    else
      redirect_to profile_path
    end    
  end  
  
  private
    def get_comment(contact)
      if contact.background_info.blank?
        comment = ""
      else
        comment = "Background Info:\n" + contact.background_info + "\n\n"
      end
      contact.comments.each { |c| comment += "#{c.updated_at}\n#{c.comment}\n\n" }
      comment
    end
  
    def get_address(address)
      add = {}
      if @single_address_field == true
        address.full_address.blank? ? add["street1"] = "" : add["street1"] = address.full_address
        add["street2"] = "" 
        add["city"] = ""
        add["state"] = "" 
        add["zipcode"] = ""
        add["country"] = ""
      else
        add["street1"] = address.street1 
        add["street2"] = address.street2
        add["city"] = address.city
        add["state"] = address.state 
        add["zipcode"] = address.zipcode
        add["country"] = address.country
      end
      add
  end
  
  def get_account(account)
    account == nil ? "" : account.name
  end
end

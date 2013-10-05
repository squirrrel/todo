class ApplicationController < ActionController::Base
  DefaultTime = :'last 7 days'  #protect_from_forgery with: :exception #to recover at a later time
  protect_from_forgery except: [:filter_by_time, :update]
  skip_before_action :verify_authenticity_token
  #respond_to :json, :html, :js
  #before_action :format_date
  rescue_from Exception, with: :handle_and_file
  before_filter :log_user, only: ['create', 'destroy']  

  private
    def handle_and_file exception
    	Rails.logger.error "#{exception.class} | Message: #{exception.message}
                           \n ---------------------- \n #{exception.backtrace[0..5]}
                           \n ----------------------"
    	render js: "$.errorMessanger({text: '#{t(:internal_server_error)[:message]}' });"
    end	

    def log_user
      logged_in_or_out = params[:action] == 'create' ? 'LOGGED-IN' : 'LOGGED-OUT' 
      Rails.logger.info "ID:#{current_user.try(:id)} | #{current_user.try(:email) ? current_user.email : 'NEWBIE REGISTERED AND'} #{logged_in_or_out}"
    end 

    def set_priorities
      [:"#{t(:priorities)[:high]}", :"#{t(:priorities)[:medium]}", :"#{t(:priorities)[:low]}"]
    end  

    def set_time_filter_options
      [:"#{t(:time_filter)[:today]}", :"#{t(:time_filter)[:last_7_days]}",:"#{t(:time_filter)[:last_14_days]}", 
        :"#{t(:time_filter)[:last_30_days]}", :"#{t(:time_filter)[:last_3_months]}", :"#{t(:time_filter)[:last_6_months]}",
         :"#{t(:time_filter)[:last_year]}",:"#{t(:time_filter)[:forever]}"]
    end  
end
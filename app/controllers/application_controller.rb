class ApplicationController < ActionController::Base
  DefaultTime = :'last 7 days'  #protect_from_forgery with: :exception #to recover at a later time
  protect_from_forgery except: [:filter_by_time, :update]
  skip_before_action :verify_authenticity_token
  #respond_to :json, :html, :js
  #before_action :format_date
  helper :application
  rescue_from Exception, with: :handle_and_file
  before_filter :log_and_send_email, only: ['create', 'destroy']  

  private
    def handle_and_file exception
    	Rails.logger.error "#{exception.class} | Message: #{exception.message}
                           \n ---------------------- \n #{exception.backtrace[0..5]}
                           \n ----------------------"
    	render js: "$.errorMessanger({text: '#{t(:internal_server_error)[:message]}' });"
    end	

    def log_and_send_email     
      if params[:action] == 'create'
        user_count = User.where(email: "#{params[:user][:email]}").count
        if params[:controller] == 'devise/registrations' && user_count == 0
          user_email = params[:user][:email]
          UserMailer.welcome_registered(user_email).deliver
          Rails.logger.info "NEWBIE REGISTERED AND SIGGNED IN"
        elsif params[:controller] == 'devise/registrations' && user_count == 1
          Rails.logger.info "NEWBIE ENTERED AN EXISTING EMAIL ADDRESS AND FAILED TO REGISTER AT devise/registrations"
        elsif params[:controller] == 'devise/sessions'
          if user_count == 1 && User.find_by_email(params[:user][:email]).valid_password?(params[:user][:password])
            Rails.logger.info "#{params[:user][:email]} SIGGNED IN"
          else
            flash.now[:notice] = t(:devise)[:failure][:not_found_in_database]
          end
        end
      elsif params[:action] == 'destroy'
        Rails.logger.info "ID:#{current_user.try(:id)} | #{current_user.try(:email)} SIGGNED OUT"
      end
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
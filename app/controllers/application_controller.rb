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
      if params[:action] == 'create' &&  params[:controller] != 'todo/active_tasks'
        user_count = User.where(email: "#{params[:user][:email]}").count 
        if params[:controller] == 'devise/passwords' && User.find_by_email(params[:user][:email]).nil?
          flash[:error] =  t(:custom_errors)[:non_existent_email]
        elsif params[:controller] == 'devise/passwords' && !User.find_by_email(params[:user][:email]).nil?
          #flash[:error] = nil
        elsif params[:controller] == 'devise/registrations' && user_count == 0
          user_email = params[:user][:email]
          Rails.logger.info "NEWBIE REGISTERED AND SIGGNED IN"
          Thread.new { UserMailer.welcome_registered(user_email).deliver } #so far there is no handling error in case invalid email is specified      
        elsif params[:controller] == 'devise/registrations' && user_count == 1
          flash[:error] = t(:custom_errors)[:mustbe_unique]
          Rails.logger.info "NEWBIE ENTERED AN EXISTING EMAIL ADDRESS AND FAILED TO REGISTER AT devise/registrations"
        elsif params[:controller] == 'devise/sessions'
          if user_count == 1 && User.find_by_email(params[:user][:email]).valid_password?(params[:user][:password])
            Rails.logger.info "#{params[:user][:email]} SIGGNED IN"
            if BasicTask.is_translated? == true
              %w{active_task_rows completed_task_rows }.each{|candidate| expire_fragment(candidate + current_user.id.to_s) }
              p "MANAGGGEEDDDD"
            else
              p 'FAILED'
            end              
          else  
            true #sessions/create redirects back to sessions/new with flash
          end
        end
      elsif params[:action] == 'destroy' && params[:controller] == 'devise/sessions'
        BasicTask.set_translation_flag= false
        p "SIGNOUT#{BasicTask.is_translated?}"
        Rails.logger.info "ID:#{current_user.try(:id)} | #{current_user.try(:email)} SIGGNED OUT"
      else
        true
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
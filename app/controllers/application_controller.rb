class ApplicationController < ActionController::Base
  Priorities = [:high, :medium, :low]
  TimeFilter = [:today, :'last 7 days',:'last 14 days', 
  				:'last 30 days', :'last 3 months', :'last 6 months',
 			 	 :'last year',:forever]
  DefaultTime = :'last 7 days'  #protect_from_forgery with: :exception #to recover at a later time
  protect_from_forgery except: [:filter_by_time, :update]
  skip_before_action :verify_authenticity_token
  #respond_to :json, :html, :js
  #before_action :format_date
  rescue_from Exception, with: :handle_and_file

  private
    def handle_and_file exception
    	Rails.logger.error "#{exception.class} | Message: #{exception.message}
                           \n ---------------------- \n #{exception.backtrace[0..5]}
                           \n ----------------------"
    	render js: "$.errorMessanger({text: '#{STORAGE.with_indifferent_access[:literals][:message]}' });"
    end	
end

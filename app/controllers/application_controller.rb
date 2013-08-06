class ApplicationController < ActionController::Base
  Priorities = [:high, :medium, :low]
  Status =  [:open, :in_progress, :completed] #remove if never used
  Types = %w{ActiveTask CompletedTask} #remove if never used
  
  protect_from_forgery with: :exception
  respond_to :json, :html, :js
  #before_action :format_date
end

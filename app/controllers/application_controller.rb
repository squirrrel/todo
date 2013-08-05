class ApplicationController < ActionController::Base
  Priorities = [:high, :medium, :low]
  Status =  [:open, :in_progress, :completed]
  Types = %w{ActiveTask CompletedTask}
  
  protect_from_forgery with: :exception
  respond_to :json, :html, :js

end

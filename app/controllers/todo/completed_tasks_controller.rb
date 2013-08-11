class Todo::CompletedTasksController < ApplicationController
	def index
	  @tasks = CompletedTask.all.order('created_at DESC')
	  @time_filter = TimeFilter
	  @priorities = Priorities
	  #p Rails.application.routes.url_helpers
	end

	# def show
	# end

	def destroy
	  CompletedTask.find(params[:id]).destroy #ensure it is destroyed
	  render js: "$('.#{params[:id]}').remove();" #ADD SOME MSSG
	end

	def reopen
      reopened = BasicTask.find(params[:id])
	  reopened.type = 'ActiveTask'
	  reopened.completed_at = Time.new(1000,01,01, 1,1,1) #.strftime('%b %e, %l:%M %p')
	  reopened.save
	  render js: "$('.#{params[:id]}').remove();" #ADD SOME MSSG
	  #perhaps it is better to add some flag column to indicate that it's been open
	end	


	def filter_by_time
	  render js: "$('.to-be-removed').remove();"
	end	
end

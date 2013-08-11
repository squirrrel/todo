class Todo::CompletedTasksController < ApplicationController

	def index
	  @tasks = CompletedTask.all.order('created_at DESC')
<<<<<<< HEAD
<<<<<<< HEAD
	  @time_filter = TimeFilter
	  @priorities = Priorities
	  #p Rails.application.routes.url_helpers
=======
>>>>>>> 7a7754e... completed tasks controller scratch
=======
	  @time_filter = TimeFilter
	  @priorities = Priorities
	  #p Rails.application.routes.url_helpers
>>>>>>> 601044d... playing with filters n completed and edit on active
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
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 601044d... playing with filters n completed and edit on active

	def filter_by_time
	  render js: "$('.to-be-removed').remove();"
	end	
<<<<<<< HEAD
=======
>>>>>>> 7a7754e... completed tasks controller scratch
=======
>>>>>>> 601044d... playing with filters n completed and edit on active
end

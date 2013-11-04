class Todo::CompletedTasksController < ApplicationController
	include Destroyable

	skip_before_filter :log_user, only: ['create', 'destroy']
	before_action :authenticate_user!

	def index
		@current_user_id = current_user.id.to_s	
	  	p @current_user_id
	  	@time_filter = set_time_filter_options
	 	@priorities = set_priorities
	 	@default_option = DefaultTime
 		@tasks =  CompletedTask.where(user_id: "#{current_user.id}").order('completed_at DESC') 		 		      	
      	render 'index.js.erb' 	
	end	

	def reopen
	  	CompletedTask.reopen_task(params[:id])
		%w{active_task_rows completed_task_rows }.each{|candidate| expire_fragment(candidate + current_user.id.to_s) }
 		@notification = t(:notifications)[:reopened]
		@controller = params[:controller]
	  	respond_to do |format|
	  		format.js{ render '/todo/shared/remove.js.erb'}
	  	end	
	end	 

	def mass_reopen
		CompletedTask.transaction do
			params[:id].each{|id| CompletedTask.reopen_task(id) }
		end
		%w{active_task_rows completed_task_rows }.each{|candidate| expire_fragment(candidate + current_user.id.to_s) }		
		@notification = t(:notifications)[:reopened]
		@controller = params[:controller]
		respond_to do |format|
	 	 	format.js{ render '/todo/shared/mass_remove.js.erb'}
	  end	
	end	

	#COMPLETE AND CONSIDER TIME FILTER FOR PRIORITY FILTER IF IT TOOK PLACE
	def filter_by_time 
		#filtered_by_time logic moved to index in order to avoid duplicated code
	end

	def filter_by_priority		   
	   @tasks = CompletedTask.force_time_filter   
	   @tasks.map!{|task| task if task.priority == params[:priority] }
	   @tasks.delete_if{|task| task == nil }
       CompletedTask.set_priority_filter = @tasks
	   if !@tasks.empty?     
	      respond_to do |format|
		     format.js{ render 'filter.js.erb' }
	      end		
	   else
		  head :ok 		  
	   end
	end
end

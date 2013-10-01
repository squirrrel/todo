class Todo::CompletedTasksController < ApplicationController

#TODO: REFACTOR INDEX
#RETEST IN 2 WEEKS CAUSE I AM TIRED TO DO IT

	def index
	  	@time_filter = TimeFilter
	 	@priorities = Priorities
	 	@default_option = DefaultTime
 		@tasks =  CompletedTask.all.order('completed_at DESC') 		 		      	


	  	respond_to do |format|
      		format.js { render 'filter.js.erb' }
     		format.html { render 'index.html.erb' } 	
	  	end
	end

	def destroy
	  CompletedTask.find(params[:id]).destroy #ensure it is destroyed
	  @notification = 'task deleted'
	  respond_to do |format|
	  	format.js{ render '/todo/shared/remove.js.erb'}
	  end			  
	end

	def mass_destroy
		p params
		CompletedTask.transaction do
			params[:id].each{|id| CompletedTask.find(id).destroy }
		end
		@notification = 'tasks deleted'
	    respond_to do |format|
		    format.js{ render '/todo/shared/mass_remove.js.erb' }
      	end		
	end	

	def reopen	
	  CompletedTask.reopen_task(params[:id])
	  @notification = 'task reopened'  
	  respond_to do |format|
	  	format.js{ render '/todo/shared/remove.js.erb'}
	  end	
	end	 

	def mass_reopen
		CompletedTask.transaction do
			params[:id].each{|id| CompletedTask.reopen_task(id) }
		end
		@notification = 'tasks reopened'
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

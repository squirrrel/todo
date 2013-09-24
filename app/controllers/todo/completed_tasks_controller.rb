class Todo::CompletedTasksController < ApplicationController

#TODO: REFACTOR INDEX
#RETEST IN 2 WEEKS CAUSE I AM TIRED TO DO IT

	def index
	  	@time_filter = TimeFilter
	 	@priorities = Priorities
	 	@default_option = DefaultTime

	 	if params[:filter].nil? && CompletedTask.flag == true
	 		@tasks = CompletedTask.force_time_filter
	 	else	
	 		@tasks = CompletedTask.force_priority_filter == nil || CompletedTask.force_priority_filter == [] ? (CompletedTask.all.order('completed_at DESC')) : (CompletedTask.force_priority_filter)   		 		      	
     		filter = params[:filter].nil? ? (DefaultTime) : (params[:filter]) 
	 	unless params[:filter] == 'forever' || params[:filter] == 'today' 
			figure = (%r{\d{1,2}}.match(filter)).try(:[],0)
			time_unit = %r{days|months}.match(filter).try(:[],0) 		   		  		
   			elapsed_time = params[:filter] == 'last year' ? (eval "1.years.ago") : (eval "#{figure.to_i}.#{time_unit}.ago")  		  
   		end
   		   		 	  		 	
	    if params[:filter] == 'forever' 
	        @tasks.delete_if{|task| task == nil }	
	        @tasks = @tasks.empty? == true ? (nil) : @tasks
	    elsif params[:filter] == 'today' 	
      		@tasks.map! do |task| 
			    task if task.completed_at.strftime('%m%d%y') == Time.now.strftime('%m%d%y') 
			end	
			@tasks.delete_if{|task| task == nil }
			@tasks = @tasks.empty? == true ? (nil) : @tasks
	 	else
 	     	if @tasks.count > 1  
 	  		  @tasks.map!{|task| task if task.completed_at.to_i >= elapsed_time.to_i }   	 
			elsif @tasks.count == 0
			  @tasks = nil  
			elsif @tasks.count == 1	
			  @tasks  if @tasks.first.completed_at.to_i >= elapsed_time.to_i			   	
			end	 	  
	 		end
	 	end

		CompletedTask.set_time_filter = @tasks
		CompletedTask.set_flag = true

	  	respond_to do |format|
      		format.js { render 'filter.js.erb' }
     		format.html { render 'index.html.erb' } 	
	  	end
	end

	def destroy
	  CompletedTask.find(params[:id]).destroy #ensure it is destroyed
	  @notification = 'task deleted'
	  respond_to do |format|
	  	format.js{ render 'remove.js.erb'}
	  end			  
	end

	def reopen
      subject = BasicTask.find(params[:id])
      paramz = { type: 'ActiveTask', completed_at: Time.new(1000,01,01, 1,1,1) }
	  subject.update_attributes(paramz)	
	  @notification = 'task reopened'  
	  respond_to do |format|
	  	format.js{ render 'remove.js.erb'}
	  end	

		 #ADD SOME MSSG
	  #perhaps it is better to add some flag column to indicate that it's been open
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

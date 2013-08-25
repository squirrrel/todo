class Todo::CompletedTasksController < ApplicationController

#TODO: I still have to test filtering with no records, today and forever
	def index
	  	@time_filter = TimeFilter
	 	@priorities = Priorities

     	if params[:filter]
	 		unless params[:filter] == 'forever' || params[:filter] == 'today' 
				figure = (%r{\d{1,2}}.match(params[:filter])).try(:[],0)
				time_unit = %r{days|months}.match(params[:filter]).try(:[],0) 		
   		  		
   				elapsed_time = params[:filter] == 'last year' ? (eval "1.years.ago") : (eval "#{figure.to_i}.#{time_unit}.ago")  		  
   			end
   			#----------
   			if CompletedTask.force_priority_filter == nil
   		 		@tasks = CompletedTask.all.order('completed_at DESC')
   		 	else
   		 		@tasks = CompletedTask.force_priority_filter
   		 	end	
   		 	#----------
	      	if params[:filter] == 'forever' 
	        	@tasks
	      	elsif params[:filter] == 'today' 	
	      		@tasks.map! do |task| 
				    task if task.completed_at.strftime('%m%d%y') == Time.now.strftime('%m%d%y') 
				end		 		
	 	    else
	 	     	if @tasks.count > 1  
	 	  		  @tasks.map!{|task| task if task.completed_at.to_i >= elapsed_time.to_i }   	 
				elsif @tasks.count == 0
				  @tasks = nil  #send some notification instead 
				elsif @tasks.count == 1	
				  @tasks  if @tasks.first.completed_at.to_i >= elapsed_time.to_i			   	
				end	 	  
	 	   	end

		else
			@tasks = CompletedTask.all.order('completed_at DESC')
		end

		CompletedTask.set_time_filter = @tasks

	  	respond_to do |format|
      	format.js { render 'filter.js.erb' }
     	format.html { render 'index.html.erb' } 	
	  end
	end

	def destroy
	  CompletedTask.find(params[:id]).destroy #ensure it is destroyed
	  render js: "$('.#{params[:id]}').remove();" #ADD SOME MSSG
	end

	def reopen
      subject = BasicTask.find(params[:id])
      paramz = { type: 'ActiveTask', completed_at: Time.new(1000,01,01, 1,1,1) }
	  subject.update_attributes(paramz)
	  render js: "$('.#{params[:id]}').remove();" #ADD SOME MSSG
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

	   if !@tasks.empty?     
	      respond_to do |format|
		     format.js{ render 'filter.js.erb' }
	      end		
	   else
		  head :ok 		  
	   end

	end	
end

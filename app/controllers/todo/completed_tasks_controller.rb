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
      subject = BasicTask.find(params[:id])
      paramz = { type: 'ActiveTask', completed_at: Time.new(1000,01,01, 1,1,1) }
	  subject.update_attributes(paramz)
	  render js: "$('.#{params[:id]}').remove();" #ADD SOME MSSG
	  #perhaps it is better to add some flag column to indicate that it's been open
	end	 

	#COMPLETE AND CONSIDER TIME FILTER FOR PRIORITY FILTER IF IT TOOK PLACE
	def filter_by_time
		 figure = (%r{\d{1,2}}.match(params[:filter])).try(:[],0).try(:to_i)	
		 time_unit = %r{days|months}.match(params[:filter]).try(:[],0) #think about today		
   		 
   		 elapsed_time = params[:filter] == 'last year' ? (eval "1.years.ago") : (eval "#{figure}.#{time_unit}.ago") 
   		  
   		 @tasks = CompletedTask.all

	      if params[:filter] == 'forever' #:forever
	        @tasks		
	 	    else
	 	     	if @tasks.count > 1  
	 	  		  @tasks.map!{|task| task if task.created_at.to_i >= elapsed_time.to_i }   	 
				elsif @tasks.count == 0
				  @tasks
				elsif @tasks.count == 1	
				  @tasks  if @tasks.created_at.to_i > elapsed_time.to_i
				elsif params[:filter] == 'today'
					@tasks.map! do |task| 
					igual = [:day, :month, :year].map! do |time_unt|	
						task.created_at.send time_unit == elapsed_time.send time_unit 
					    end
					task if igual    
					end				
				else
				#   	
				end	 	   
	 	   end
	 	 
	 end

	 def filter_by_priority	 	
	 end	
end

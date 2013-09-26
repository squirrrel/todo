class Todo::ActiveTasksController < ApplicationController
	def index
		@tasks = ActiveTask.all.order('created_at DESC')
		#BasicTask.where(type:'ActiveTask').order('created_at DESC')
		@priorities = Priorities
		#render json: tasks 
	end

	def new
		#@new_task = ActiveTask.new
		@priorities = Priorities
	end

	def create
		new_task = ActiveTask.new
		new_task.attributes.map do |attr, value|
			new_task[attr] = params[:new][attr] if params[:new].include?(attr)	
		end 
		#new_task.type = new_task.class.name - no need as rails handles it on his own		
		new_task.save if new_task.valid?
		
		items = %w{description priority status created_at}.map!{|prop| new_task.send prop}	
		row = "<tr>#{(items.map{|itm| '<td>' +itm.to_s+ '</td>'}).join('')}</tr>"
		notification = 'task created!'

		render js: "! function(){ 
						$('#{row}').insertBefore('.task-items');
						$.easyNotification({text: '#{notification}'});
					}();"
	end

	 def edit
	 	@post = ActiveTask.find params[:id]
	 end

	 def update_task
	 	subject = ActiveTask.find(params[:id])
	 	subject.update_attributes(params.permit(:id, :description, :priority, :status))
	 	
	 	head :ok
	 end
	## make destroy and mass destroy one single action at a later time
	def destroy
		ActiveTask.find(params[:id]).destroy 
		@notification = 'task deleted'
 		respond_to do |format|
	  		format.js{ render '/todo/shared/remove.js.erb'}
	  	end
	end

	### TRANSACTION HERE
	def mass_destroy
		params[:id].each{|id| ActiveTask.find(id).destroy }
		@notification = 'tasks deleted'
	    respond_to do |format|
		    format.js{ render '/todo/shared/mass_remove.js.erb' }
      	end		
	end

	## make complete and mass complete one single action at a later time
	def complete
		ActiveTask.complete_task params[:id]
		@notification = 'task completed'
	    respond_to do |format|
		    format.js{ render '/todo/shared/remove.js.erb' }
      	end	
	end	

	#TRANSACTION HERE
	def mass_complete
		params[:id].each{ |id| ActiveTask.complete_task(id)}
		@notification = 'tasks completed'
		respond_to do |format|
		    format.js{ render '/todo/shared/mass_remove.js.erb' }
      	end
	end	
end


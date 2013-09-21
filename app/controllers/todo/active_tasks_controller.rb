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
		render js: "$('<tr>#{items.map{|itm| '<td>' +itm.to_s+ '</td>'}}</tr>').insertBefore('.task-items')"
		#### RENDERING delete_complete_update partial ideally:
		#1: respond_to {|format| format.js } 2: use correct syntax at create.js.erb and bingo
		#$('.render-here').html('#{render :partial => 'delete_complete_update.html.erb', :locals => {:task => @task} }')
		####

		 #todo: 
		 #make date look like '%e %b, %H:%m %p' or +year mention if it was last year, update it at a application controller level
		 #move something to the model if needed
		 #Delete Update and Complete will be than shown if the tr hovered so no need to add them as well
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
		ActiveTask.find(params[:id]).destroy #ensure it is destroyed
		render js: "$('.#{params[:id]}').remove()" #ADD SOME MSSG
	end

	def mass_destroy
		params[:id].each{|id| ActiveTask.find(id).destroy }
	    respond_to do |format|
		    format.js{ render 'mass_remove.js.erb' }
      	end		
	end

	## make complete and mass complete one single action at a later time
	def complete
		subject = BasicTask.find(params[:id])
		### NOT WORKING HAVE TO FIX IT
		#paramz = { type: 'CompletedTask', completed_at: Time.now }
		#subject.update_attributes(paramz)
		subject.type = 'CompletedTask'
		subject.status = 'completed'
		subject.completed_at = Time.now
		subject.save
		render js: "$('.#{params[:id]}').remove()" #ADD SOME MSSG
	end	

	def mass_complete
		params[:id].each do |id|
			subject = BasicTask.find(id)
			### NOT WORKING HAVE TO FIX IT
			#paramz = { type: 'CompletedTask', completed_at: Time.now }
			#subject.update_attributes(paramz)
			subject.type = 'CompletedTask'
			subject.status = 'completed'
			subject.completed_at = Time.now
			subject.save
		end
		
		respond_to do |format|
		    format.js{ render 'mass_remove.js.erb' }
      	end
	end	
end


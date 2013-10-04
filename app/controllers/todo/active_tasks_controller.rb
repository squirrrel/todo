class Todo::ActiveTasksController < ApplicationController
	include Destroyable
	
	skip_before_filter :log_user, only: ['create', 'destroy']
	before_action :authenticate_user!

	def index

		@priorities = set_priorities
		@tasks = ActiveTask.where(user_id: "#{current_user.id}").order('created_at DESC')
		#BasicTask.where(type:'ActiveTask').order('created_at DESC')
		#render json: tasks 
	end

	def new
		#@new_task = ActiveTask.new
		@priorities = Priorities
	end

	def create
		new_task = ActiveTask.create(description: params[:new]['description'] , priority: params[:new]['priority'])
		new_task.update_attribute(:user_id, current_user.id)
		#new_task.type = new_task.class.name - no need as rails handles it on his own!!!		
		items = %w{description priority status created_at}.map!{|prop| new_task.send prop}	
		row = "<tr>#{(items.map{|itm| '<td>' +itm.to_s+ '</td>'}).join('')}</tr>"
		notification = t(:notifications)[:created]
		render js: "! function(){ 
						$('#{row}').insertBefore('table#1 .task-items');
						$.easyNotification({text: '#{notification}'});
					}();"
	end

	 def edit
	 	@post = ActiveTask.find params[:id]
	 end

	 def update_task
	 	subject = ActiveTask.find(params[:id])
	 	subject.update_attributes({id: params[:id], description: params[:description], 
	 								priority: params[:priority], status: params[:status]})
	 	notification = t(:notifications)[:updated]
	 	render js: "! function(){$.easyNotification({text: '#{notification}'});}();"
	 end

	def complete
		ActiveTask.complete_task params[:id]
		@notification = t(:notifications)[:completed]
	    respond_to do |format|
		    format.js{ render '/todo/shared/remove.js.erb' }
      	end	
	end	

	def mass_complete
		ActiveTask.transaction do
			params[:id].each{ |id| ActiveTask.complete_task(id)}
		end
		@notification = t(:notifications)[:completed]
		respond_to do |format|
		    format.js{ render '/todo/shared/mass_remove.js.erb' }
      	end
	end	
end


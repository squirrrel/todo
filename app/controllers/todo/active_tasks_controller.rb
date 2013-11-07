class Todo::ActiveTasksController < ApplicationController
	include Destroyable
	
	skip_before_filter :log_user, only: ['create', 'destroy']
	before_action :authenticate_user!	

	def index
		@current_user_id = current_user.id.to_s
		@priorities = set_priorities
		@tasks = ActiveTask.where(user_id: "#{current_user.id}").order('created_at DESC')
		#BasicTask.where(type:'ActiveTask').order('created_at DESC')
		#render json: tasks 
		respond_to do |format|
			format.js{ render 'index.js.erb' }
			format.html{ render 'index.html.erb' } 
		end
	end

	def new
		#@new_task = ActiveTask.new
		@priorities = Priorities
	end

	def create
		p request.port
		p request.host
		new_task = ActiveTask.create(description: params[:new]['description'] , priority: params[:new]['priority'])
		new_task.update_attribute(:user_id, current_user.id)
		#new_task.type = new_task.class.name - no need as rails handles it on his own!!!		
		localised_items = %w{description priority status created_at}.map! do |prop| 
		res = new_task.send prop
		case prop
			when 'priority' then
				res == 'high' ? (t(:priorities)[:high]) : ( res == 'medium' ? t(:priorities)[:medium] : t(:priorities)[:low] )	
			when 'status' then
				res == 'open' ? t(:views)[:status][:open] : t(:views)[:status][:in_progress] 
			when 'created_at' then
				res.strftime("%a, %b %e, %l:%M %p")
			else
				res
			end
		end
		expire_fragment("active_task_rows#{current_user.id}")
		#row = "<tr>#{(localised_items.map{|itm| '<td>' +itm.to_s+ '</td>'}).join('')}</tr>"
		notification = t(:notifications)[:created]
		render js: "! function(){ 
						$.ajax({type: 'GET', url:'http://localhost:8089/todo/'});
						$.easyNotification({text: '#{notification}'});
					}();"
	end

	 def edit
	 	@post = ActiveTask.find params[:id]
	 end

	 def update_task
	 	subject = ActiveTask.find(params[:id])
	 	subject.update_attributes({description: params['description'], 
	 								priority: params['priority'], status: params['status']})
		expire_fragment("active_task_rows#{current_user.id}")
	 	notification = t(:notifications)[:updated]
	 	render js: "! function(){ 
	 					$.ajax({type: 'GET', url:'http://localhost:3000/todo/'});
					}();"
	 end

	def complete
		#p read_fragment("active_task_rows#{current_user.id}")
		ActiveTask.complete_task params[:id]
		%w{active_task_rows completed_task_rows }.each{|candidate| expire_fragment(candidate + current_user.id.to_s) }
		@notification = t(:notifications)[:completed]
		@controller = params[:controller]
	    respond_to do |format|
		    format.js{ render '/todo/shared/remove.js.erb' }
      	end	
	end	

	def mass_complete
		ActiveTask.transaction do
			params[:id].each{ |id| ActiveTask.complete_task(id)}
		end
		%w{active_task_rows completed_task_rows }.each{|candidate| expire_fragment(candidate + current_user.id.to_s) }
		@notification = t(:notifications)[:completed]
		@controller = params[:controller]
		respond_to do |format|
		    format.js{ render '/todo/shared/mass_remove.js.erb' }
      	end
	end	
end


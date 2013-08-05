class Todo::ActiveTasksController < ApplicationController
	def index
		@tasks = BasicTask.where(type:'ActiveTask').order('created_at DESC')
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
		render js: "$('<tr>#{items.map{|itm| '<td>' +itm.to_s+ '</td>'}}</tr>').insertBefore('.task-items');"
		 #install plugin for refactorying code adn higlighting stuff
		 #todo: 
		 #make a nice README
		 #make date look like '%e %b, %H:%m %p' or +year mention if it was last year, update it at a application controller level
		#move something to the model if needed
	end

	def show
	end

	def edit
	end

	def update  
	end
end


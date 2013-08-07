class Todo::ActiveTasksController < ApplicationController
	def index
		@tasks = BasicTask.where(type:'ActiveTask').order('created_at DESC') #perhaps we can just ActiveTask it and it will guess
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
		 #add search functionality to the framework to be able to search tasks faster?
		 #make a nice README
		 #make date look like '%e %b, %H:%m %p' or +year mention if it was last year, update it at a application controller level
		 #move something to the model if needed
		 #Delete Update and Complete will be than shown if the tr hovered so no need to add them as well
		 #Find out why is destroy and complete require templates!!! 
	end

	# def show
	# end

	# def edit
	# end

	# def update  
	# end

	def destroy
		ActiveTask.find(params[:id]).destroy #ensure it is destroyed
		render js: "$('.#{params[:id]}').remove();" #ADD SOME MSSG
	end

	def complete
		completed = BasicTask.find(params[:id])
		completed.type = 'CompletedTask'
		completed.save
		render js: "$('.#{params[:id]}').remove();" #ADD SOME MSSG
	end	
end


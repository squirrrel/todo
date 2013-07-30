class Todo::ActiveTasksController < ApplicationController
	SCOPE = self
	def index
		@tasks = BasicTask.where(type:'ActiveTask')
		@priorities = Priorities
		#render json: tasks 
	end

	def new
		#@new_task = ActiveTask.new
		@priorities = Priorities
	end

	def create
		#move it to the model?
		new_task = ActiveTask.new
		new_task.attributes.map do |attr, value|
			new_task[attr] = params[:new][attr] if params[:new].include?(attr)	
		end 
		new_task.type = new_task.class.name
		new_task.save
		 #js: 
		 #todo: 
		 #make a nice README
		 #save it to the database, specifying self for the type column
		 #WTF is it setting up type as ActiveTask???
		 #complete ajax from the coffee script
		 #update index action maybe using ajax
	end

	def show
	end

	def edit
	end

	def update  
	end
end


class Todo::ActiveTasksController < ApplicationController
	
	def index
		@tasks = BasicTask.where(type:'ActiveTask')
		#render json: tasks
		render @tasks 
	end

	def new
		@new_task = ActiveTask.new
		@priorities = Priorities
	end

	def create
		p params[:new]
		 #"new"=>{"new_task"=>"dsmndslk"}, "post"=>{"person_id"=>"high"}
		 p self
		 #todo: 
		 #make a nice README
		 #save it to the database, specifying self for the type column
		 #update index action maybe using ajax

	end

	def show
	end

	def edit
	end

	def update  
	end
end


class Todo::ActiveTasksController < ApplicationController

	def index
		tasks = BasicTask.find_by type: 'ActiveTask'
		render json:  tasks 
	end

	def new
	end

	def create
	end

	def show
	end

	def edit
	end

	def update  
	end
end

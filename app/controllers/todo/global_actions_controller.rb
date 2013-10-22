class Todo::GlobalActionsController < ApplicationController
	def translate
		I18n.locale = /GB/.match(params[:flag_path]) ? :en : :ua 
		respond_to do |format|
			format.js{ render 'translate.js.erb' }
		end  
	end
end
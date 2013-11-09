class Todo::GlobalActionsController < ApplicationController

#have used a temporary hack to protect these two actions from direct web-search access based on the params passed
	def translate
		@referrer = request.env["HTTP_REFERER"]
		if params['flag_path']
         if @referrer =~ /^#{SETTINGS[ENV['RAILS_ENV']]['url']}$/
           %w{active_task_rows completed_task_rows }.each{|candidate| expire_fragment(candidate + current_user.id.to_s) }
         else
           #donothing
         end
			BasicTask.set_translation_flag= true 
			p "TRANSLATION#{BasicTask.is_translated?}"
			I18n.locale = /GB/.match(params[:flag_path]) ? :en : :ua 
			flash[:error] = nil
			@hack = true
		 	respond_to do |format|
			  	format.js{ render 'translate.js.erb' }
 		  	end	
 		else
			render 'forbidden', status: :forbidden 
		end  
	end

	def not_found	
		params['404'] ? (render 'not_found') : (render 'forbidden', status: :forbidden)
	end
end
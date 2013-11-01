module Destroyable
	extend ActiveSupport::Concern

	included do
		def destroy
			BasicTask.find(params[:id]).destroy 
			expire_fragment("#{params[:controller] == 'todo/completed_tasks' ? 'completed_task_rows' : 'active_task_rows'}#{current_user.id}")
			@notification = t(:notifications)[:deleted]
			respond_to do |format|
				format.js{ render '/todo/shared/remove.js.erb'}
			end
		end

		def mass_destroy
			BasicTask.transaction do
				params[:id].each{|id| BasicTask.find(id).destroy }
			end
			expire_fragment("#{params[:controller] == 'todo/completed_tasks' ? 'completed_task_rows' : 'active_task_rows'}#{current_user.id}")	
			@notification = t(:notifications)[:deleted]
			respond_to do |format|
				format.js{ render '/todo/shared/mass_remove.js.erb' }
			end		
		end
	end
end	
module Destroyable
	extend ActiveSupport::Concern

	included do
		def destroy
			BasicTask.find(params[:id]).destroy 
			@notification = t(:notifications)[:deleted]
			respond_to do |format|
				format.js{ render '/todo/shared/remove.js.erb'}
			end
		end

		def mass_destroy
			BasicTask.transaction do
				params[:id].each{|id| BasicTask.find(id).destroy }
			end
			@notification = t(:notifications)[:deleted]
			respond_to do |format|
				format.js{ render '/todo/shared/mass_remove.js.erb' }
			end		
		end
	end
end	
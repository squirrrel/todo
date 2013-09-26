class ActiveTask < BasicTask
   include ActiveModel::ForbiddenAttributesProtection
	
   validates :description, presence: true
   validates :priority, presence: true

   def self.complete_task id
   		subject = ActiveTask.find(id)
		### NOT WORKING HAVE TO FIX IT
		#paramz = { type: 'CompletedTask', completed_at: Time.now }
		#subject.update_attributes(paramz)
		subject.type = 'CompletedTask'
		subject.status = 'completed'
		subject.completed_at = Time.now
		subject.save
	end	
end

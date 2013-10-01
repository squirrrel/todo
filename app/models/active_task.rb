class ActiveTask < BasicTask
	
   validates :description, presence: true
   validates :priority, presence: true

   def self.complete_task id
   		subject = ActiveTask.find(id)		
		subject.update_attributes({status: 'completed', type: 'CompletedTask', completed_at: Time.now}) 
	end	
end

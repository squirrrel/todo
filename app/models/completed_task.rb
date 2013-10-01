class CompletedTask < BasicTask
	
	@time = nil 
	@priority = nil
	@flag = nil

	def self.force_time_filter
		@time
	end

	def self.set_time_filter=(var)
		@time = var
	end

	def self.force_priority_filter
		@priority
	end

	def self.set_priority_filter=(var)
		@priority = var
	end	

	def self.set_flag=(var)
		@flag = var
	end	

	def self.flag
		@flag
	end	

	def self.reopen_task id
	    subject = BasicTask.find(id)
	  	subject.update_attributes({status: 'open', type: 'ActiveTask', created_at: Time.now, completed_at: Time.new(1000,01,01, 1,1,1)})
	end	
end

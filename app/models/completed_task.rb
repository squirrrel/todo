class CompletedTask < BasicTask
  	include ActiveModel::ForbiddenAttributesProtection
	
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
end

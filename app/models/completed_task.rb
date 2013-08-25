class CompletedTask < BasicTask
	@time = nil 
	@priority = nil

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
		@priority
	end	
end

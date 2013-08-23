class ActiveTask < BasicTask

	validates :description, presence: true
	validates :priority, presence: true
end

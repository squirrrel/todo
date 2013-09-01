class ActiveTask < BasicTask
   include ActiveModel::ForbiddenAttributesProtection
	
   validates :description, presence: true
   validates :priority, presence: true
end

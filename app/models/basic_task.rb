class BasicTask < ActiveRecord::Base
	include ActiveModel::ForbiddenAttributesProtection
#attr_accessible :description, :priority, :status
#attr_protected	:type, :created_at, :completed_at

 #    def format_date
 # if self.created_at.year == Time.now.year
 #  self.created_at.strftime('%b %e, %l:%M %p')
 # else
 #  self.created_at.strftime('%b %e %Y')
 # end
 # end
end

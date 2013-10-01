require 'protected_attributes'

class BasicTask < ActiveRecord::Base
include ActiveModel::ForbiddenAttributesProtection
attr_accessible :type, :completed_at, :status, :description, :priority, :id, :created_at

 #    def format_date
 # if self.created_at.year == Time.now.year
 #  self.created_at.strftime('%b %e, %l:%M %p')
 # else
 #  self.created_at.strftime('%b %e %Y')
 # end
 # end
end

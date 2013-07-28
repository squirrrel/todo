class BasicTask < ActiveRecord::Base

attr_accessible :description, :priority, :status  
attr_protected	:type, :created_at, :completed_at


end

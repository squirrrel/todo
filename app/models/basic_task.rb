require 'protected_attributes'

class BasicTask < ActiveRecord::Base
	include ActiveModel::ForbiddenAttributesProtection

	belongs_to :user
	attr_accessible :type, :completed_at, :status, :description, :priority, :id, :created_at
end

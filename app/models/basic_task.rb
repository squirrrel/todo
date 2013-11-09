require 'protected_attributes'

class BasicTask < ActiveRecord::Base
	include ActiveModel::ForbiddenAttributesProtection

	belongs_to :user, touch: true
	attr_accessible :type, :completed_at, :status, :description, :priority, :id, :created_at

	@flag = false

	def self.is_translated?
		@flag
	end

	def self.set_translation_flag=(var=false)
		@flag = var
	end
end
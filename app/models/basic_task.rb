require 'protected_attributes'

class BasicTask < ActiveRecord::Base
	include ActiveModel::ForbiddenAttributesProtection

	belongs_to :user, touch: true
	attr_accessible :type, :completed_at, :status, :description, :priority, :id, :created_at

	@flag = false
	@language = 'en'

	def self.is_translated?
		@flag
	end

	def self.set_translation_flag=(var=false)
		@flag = var
	end

	def self.language_settings
		@language
	end

	def	self.set_language=(var)
		@language = var
	end	
end
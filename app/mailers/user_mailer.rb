class UserMailer < ActionMailer::Base
	layout 'mailer'  
	default from: "from@example.com"

	def reset_instructions user_email
		@user_email = user_email
		@url = "#{SETTINGS[ENV['RAILS_ENV']]['url']}/todo/user/password/edit"
		mail(to: @user_email, subject: 'You have requested to change your #TODO list password')
	end	

	def welcome_registered user_email
		@user_email = user_email
		@url = "#{SETTINGS[ENV['RAILS_ENV']]['url']}/todo/user/signin"
		@admin_email = 'nina.moskalyk@gmail.com'
		mail(to: @user_email, subject: 'Congratulations, you have got your own #TODO list')
	end	
end
class WelcomeController < ApplicationController
  require 'mail'
  skip_before_action :verify_authenticity_token

  def index
  end

  def pics
  end

  def mail
  	Mail.defaults do
	  delivery_method :smtp, {
	    :address => 'smtp.sendgrid.net',
	    :port => '587',
	    :domain => 'heroku.com',
	    :user_name => ENV['SENDGRID_USERNAME'],
	    :password => ENV['SENDGRID_PASSWORD'],
	    :authentication => :plain,
	    :enable_starttls_auto => true
	  }
	end
  	name = params[:name]
  	email = params[:email]
  	phone = params[:phone]
  	message = params[:message]
  	Mail.deliver do
	  from     email
	  to       'nick.helvig@gmail.com'
	  subject  'Someone emailed you from your site!'
	  body     message + "\n The phone number to reach this person is: " + phone
	end
	puts "IT EMAILED!"
	render :json => { :success => "success", :status_code => "200" }
  end

end

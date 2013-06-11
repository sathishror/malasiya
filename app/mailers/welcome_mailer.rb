class WelcomeMailer < ActionMailer::Base
  default :from => "from@example.com"
  layout false 
  def for_user(user, password)
    @user = user
    @password = password
    mail(:to => @user.email, :subject => "Welcome to Melaka")
  end
end

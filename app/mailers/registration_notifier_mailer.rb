class RegistrationNotifierMailer < ApplicationMailer

  def send_key(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Dispachio!')
  end

end

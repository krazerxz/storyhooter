class NewUserMailer < ApplicationMailer
  default from: 'hello.storyhooter@gmail.com'

  def new_user_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end
end

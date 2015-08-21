class NewUserMailer < ApplicationMailer
  default from: 'hello.storyhooter@gmail.com'

  def new_user_email(user)
    @user = user
    mail(to: @user.email, subject: "StoryHooter - #{@user.name}, your story begins here!")
  end
end

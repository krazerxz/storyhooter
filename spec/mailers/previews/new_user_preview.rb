# Preview all emails at http://localhost:3000/rails/mailers/new_user/mailer
class NewUserMailerPreview < ActionMailer::Preview
  def new_user_email_preview
    NewUserMailer.new_user_email(User.first)
  end
end

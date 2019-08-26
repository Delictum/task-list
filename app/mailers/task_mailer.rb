class TaskMailer < ActionMailer::Base
  default from: "email.event.planning@gmail.com"

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end

  def sample_modified_task_email(admin)
    @admin = admin
    mail(to: @admin.email, subject: 'Sample Modified Task Email')
  end
end

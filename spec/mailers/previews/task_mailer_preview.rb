# Preview all emails at http://localhost:3000/rails/mailers/task_mailer
class TaskMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    TaskMailer.sample_email(User.first)
  end

  def sample_modified_task_email
    TaskMailer.sample_email(Admin.first)
  end
end

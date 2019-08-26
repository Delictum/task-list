class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(id)
    @user = User.find(id)
    TaskMailer.sample_email(@user).deliver_now
  end
end

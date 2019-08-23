class SendModifiedTaskEmailJob < ActiveJob::Base
  queue_as :default

  def perform(admin)
    @admin = admin
    TaskMailer.sample_email(@admin).deliver_later
  end
end

class SendTaskModifiedJob < ApplicationJob
  queue_as :default

  def perform(id)
    @admin = Admin.find(id)
    TaskMailer.sample_modified_task_email(@admin).deliver_now
  end
end

class ShareMailer < ActionMailer::Base
  def share_list list, receiver, sender
    @list = list
    @sender = sender
    @receiver = receiver
    mail(:to => "#{receiver.name} <#{receiver.email}>", :subject => "#{receiver.name} shared a list with you!")
  end
end

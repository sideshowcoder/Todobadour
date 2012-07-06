class ShareMailer < ActionMailer::Base
  default :from => "norepley@todobadour.sideshowcoder.com"
  
  def share_list list, sender, receiver, message
    @list = list
    @sender = sender
    @receiver = receiver
    @message = message
    mail(:to => "#{@receiver}", :subject => "#{@sender} shared a list with you!")
  end
end

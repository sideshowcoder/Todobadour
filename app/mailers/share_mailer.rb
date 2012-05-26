class ShareMailer < ActionMailer::Base
  default :from => "norepley@todobadour.herokuapp.com"
  
  def share_list list, receiver, sender
    @list = list
    @sender = sender
    @receiver = receiver
    mail(:to => "#{@receiver}", :subject => "#{@sender} shared a list with you!")
  end
end

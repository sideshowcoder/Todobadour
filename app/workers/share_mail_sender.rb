class ShareMailSender
  @queue = :share_mail_send_queue
  
  def self.perform list_id, sender, receiver, message
    list = List.find list_id
    ShareMailer.share_list(list, sender, receiver, message).deliver
  end
  
end
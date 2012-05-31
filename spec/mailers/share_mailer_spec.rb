require "spec_helper"

describe ShareMailer do
  describe 'share_list' do
    before(:each) do
      @list = FactoryGirl.create :list
      @sender = "test@test.com"
      @receiver = "test2@test2.com"
    end
    
    let(:mail) do
      ShareMailer.share_list(@list, @sender, @receiver).deliver
    end
    
    it 'renders the subject' do
      mail.subject.should == "#{@sender} shared a list with you!"
    end
 
    it 'renders the receiver email' do
      mail.to.should == [@receiver]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ['norepley@todobadour.herokuapp.com']
    end
 
    #ensure that the @name variable appears in the email body
    it 'assigns @list' do
      mail.body.encoded.should match(@list.title)
    end
  end
end
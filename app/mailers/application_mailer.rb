class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.localhost',
          template_path: 'mailers/items' 

  def item_vote(item , mail)
    @item = item 
    @mail = mail
    mail to: @mail,
            subject: "Your post or example was voted"
  end

end

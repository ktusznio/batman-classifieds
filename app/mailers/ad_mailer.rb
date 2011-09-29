class AdMailer < ActionMailer::Base
  default :from => "classifieds@example.com"

  def contact(user, ad, message)
    @user, @ad, @message = user, ad, message
    mail(
      :to       => ad.user.email,
      :subject  => "[Classifieds] #{user.display_name}. is interested in your ad",
      :reply_to => user.email
    )
  end
end

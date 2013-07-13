# encoding: utf-8

class Message < ActionMailer::Base
  #default from: "contact@tabi-repo.net"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message.contact.subject
  #
  def contact(contact)
    @contact = contact
    mail(
      to:      'contact@tabi-repo.net',
      subject: 'お問い合わせ',
      from: @contact.email
    ) do |format|
      format.html
    end
  end
end

class UserMailer < ApplicationMailer
  def registration_email email, password
    @email = email
    @password = password
    mail(
      to: email,
      subject: 'There is an registration with your email'
    )
  end

  def reset_password email, password
    @email = email
    @password = password
    mail(
      to: email,
      subject: 'Your password has already been reset.'
    )
  end
end

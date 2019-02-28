class RegistrationsMailer < ApplicationMailer
  def registration(registration)
    @registration = registration
    @event = @registration.event
    @other_pilots = registration.clashing.map { |reg| reg.user }
    # Send email on new registration
    mail(to: @registration.user.email, subject: "KillaKwads event registration")
  end
  
  def registration_clash(registration)
    @registration = registration
    @event = @registration.event
    @other_pilots = registration.clashing.map { |reg| reg.user }
    mail(to: @registration.user.email, subject: "KillaKwads event update")
  end
end

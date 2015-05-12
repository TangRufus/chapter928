class TicketMailer < ApplicationMailer
  def new_ticket(ticket, pdf)
    attachments["#{ticket.number}.pdf"] = pdf
    mail(to: ticket.email,
    subject: 'CHAPTER: 9.28 購票確認Ticket Confirmation'
    )
  end
end

class Ticket < ActiveRecord::Base
  def self.prices
    {
      'Free': 0,
      'HKD $110': 110
    }
  end

  def self.scenes
    {
      '23 May 20:00': DateTime.new(2015, 5, 23, 20, 0),
      '24 May 14:00': DateTime.new(2015, 5, 23, 13, 0),
      '24 May 20:00': DateTime.new(2015, 5, 24, 20, 0),
      '29 May 20:00': DateTime.new(2015, 5, 29, 20, 0)
    }
  end

  auto_strip_attributes :email, :number, delete_whitespaces: true
  # auto_strip_attributes :number :delete_whitespaces: true

  before_save :upcase_number
  after_commit :deliver_new_ticket_email

  validates :email, presence: true, :email => true
  validates :price, presence: true, inclusion: { in: Ticket.prices.values }
  validates :scene, presence: true, inclusion: { in: Ticket.scenes.values }
  validates :number, presence: true, uniqueness: true

  def display_price
    if price == 0
      'Free'
    else
      "HKD $#{price}"
    end
  end

  def upcase_number
    self.number.upcase!
  end

  def deliver_new_ticket_email
    pdf = genmerate_pdf
    TicketMailer.new_ticket(self, pdf).deliver_now
  end

  def genmerate_pdf
    # create an instance of ActionView, so we can use the render method outside of a controller
    av = ActionView::Base.new()
    av.view_paths = ActionController::Base.view_paths

    # need these in case your view constructs any links or references any helper methods.
    av.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
    end

    pdf_html = av.render pdf: self, template: "tickets/show.pdf.erb", layout: nil, locals: {ticket: self}
    # use wicked_pdf gem to create PDF from the doc HTML
    doc_pdf = WickedPdf.new.pdf_from_string(pdf_html)
  end
end

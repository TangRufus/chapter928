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
end

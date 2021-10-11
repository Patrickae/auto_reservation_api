class Customer < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :email, allow_blank: true
  validates :phone_number, presence: true, phone: {possible: true, allow_blank: false}, uniqueness: true
  before_validation :normalize_phone

  has_many :vehicles

  private

  def normalize_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end

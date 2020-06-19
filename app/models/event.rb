class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :attendees
  has_many :attending, through: :attendees, source: :user

  # validations
  validates :name, :location, presence: true
  validates :state, presence: true
  validate :valid_date

  private

  def valid_date
    if date.present? && date < Date.today
      errors.add(:date, "Date can't be in the past")
    end
  end


end

class User < ActiveRecord::Base
  has_secure_password

has_many :events
has_many :comments, dependent: :destroy
has_many :attendees
has_many :event_attendees, through: :attendees, source: :event

  
  validates :password, presence: true, length: { minimum: 8}, :if => :password

  validates :fname, presence: true
  validates :lname, presence: true

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_Sensitive:false }, format: { with: EMAIL_REGEX}

  validates :location, presence: true
  validates :state, presence: true


before_save :email_lowercase

def email_lowercase
  email.downcase!
end

def error_validations
  errors.add(:password, "must be at least 8 characters long")
  errors.add(:email, "enter a valid email address")
end

end

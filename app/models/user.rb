class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: {case_sensitive: false}
  validate :valid_email
  validate :valid_password

  private
  def valid_password
    if self.password.nil?
      errors.add(:password, "required")
    elsif self.password.length < 8
      errors.add(:password, "length")
    elsif self.password.upcase == self.password
      errors.add(:password, "needs lower")
    elsif self.password.downcase == self.password
      errors.add(:password, "needs upper")
    elsif !self.password.match(/\d/)
      errors.add(:password, "needs number")
    elsif !self.password.match(/[^\w\s]/)
      errors.add(:password, "needs special")
    end
  end
  
  def valid_email
    if self.email.nil?
      errors.add(:email, "required")
    elsif !self.email.match(/(([^<>()\[\]\\.,;:\s@\"]+(\.[^<>()\[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))/)
      errors.add(:email, "invalid")
    end
  end
end

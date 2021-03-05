class User < ApplicationRecord
  has_many :tasks

  validates :email, presence: true, uniqueness: true, format: { with: /[\w]+@([\w-]+\.)+[\w-]{2,4}/ }
  validates :password, presence: true, confirmation: true, length: { minimum: 4 }
  validates :nickname, presence: true

  before_create :encrypt_password

  private
  def encrypt_password
    self.password = 
  end
end

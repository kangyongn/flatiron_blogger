class User < ApplicationRecord
  belongs_to :cohort
  has_many :blogs

  validates :name, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  has_secure_password
end

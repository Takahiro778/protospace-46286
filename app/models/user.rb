class User < ApplicationRecord
  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Association
  has_many :prototypes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Validations
  validates :name, :profile, :occupation, :position, presence: true
end

class Prototype < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  validates :title, :catch_copy, :concept, presence: true
  validates :image, presence: true
end
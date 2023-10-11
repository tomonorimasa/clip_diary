class Board < ApplicationRecord
  mount_uploader :video, VideoUploader
  belongs_to :user

  has_many :boards, dependent: :destroy
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :video, :presence => true
end

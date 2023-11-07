class Board < ApplicationRecord
  mount_uploader :video, VideoUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :board_tags, dependent: :destroy
  has_many :tags, through: :board_tags

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :video, :presence => true

  def save_tag(tag_list)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags

    old_tags.each do |old_name|
      tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      board_tag = Tag.find_or_create_by(name: new_name)
      tags << board_tag
    end
  end
end

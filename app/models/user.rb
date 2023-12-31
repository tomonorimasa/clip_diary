class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_boards, through: :likes, source: :board

  enum role: { general: 0, admin: 1 }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :nickname, presence: true, length: { maximum: 255 }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :description, length: { maximum: 500 }

  def own?(object)
    id == object.user_id
  end


  def like(board)
    like_boards << board
  end

  def unlike(board)
    like_boards.destroy(board)
  end

  def like?(board)
    like_boards.include?(board)
  end
end

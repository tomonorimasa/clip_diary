class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :boards
  has_many :comments, dependent: :destroy

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :nickname, presence: true, length: { maximum: 255 }

  def own?(object)
    id == object.user_id
  end
end

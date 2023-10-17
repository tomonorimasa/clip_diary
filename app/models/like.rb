class Like < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :user_id, uniqueness: { scope: :board_id }
  #一人のユーザーは同じ投稿に対して一回しかお気に入りができませんというバリデーション
end

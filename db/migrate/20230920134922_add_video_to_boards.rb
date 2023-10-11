class AddVideoToBoards < ActiveRecord::Migration[5.2]
  def change
    add_column :boards, :video, :string
  end
end

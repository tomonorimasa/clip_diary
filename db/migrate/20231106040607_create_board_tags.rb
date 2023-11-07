class CreateBoardTags < ActiveRecord::Migration[5.2]
  def change
    create_table :board_tags do |t|
      t.references :board, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end

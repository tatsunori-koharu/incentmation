class CreatePromotionLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :promotion_likes do |t|
      t.references :user
      t.references :promotion

      t.timestamps
    end
  end
end

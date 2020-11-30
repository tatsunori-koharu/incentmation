class CreatePromotionComments < ActiveRecord::Migration[6.0]
  def change
    create_table :promotion_comments do |t|
      t.text       :comment
      t.references :promotion, foreign_key: true 
      t.references :user,    foreign_key: true

      t.timestamps
    end
  end
end

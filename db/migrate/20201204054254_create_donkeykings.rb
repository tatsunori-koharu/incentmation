class CreateDonkeykings < ActiveRecord::Migration[6.0]
  def change
    create_table :donkeykings do |t|
      t.string :tweet, null: false
      t.references :user, foreign_key: true
      t.datetime :deleted_at, null: false

      t.timestamps
    end
  end
end

class CreateArticleLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :article_likes do |t|
      t.references :user
      t.references :article

      t.timestamps
    end
  end
end

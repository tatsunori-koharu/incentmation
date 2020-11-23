class CreateArticleComments < ActiveRecord::Migration[6.0]
  def change
    create_table :article_comments do |t|
      t.text       :comment,  null: false
      t.references :article,  null: false, foreign_key: true
      t.references :user,     null: false, foreign_key: true

      t.timestamps
    end
  end
end

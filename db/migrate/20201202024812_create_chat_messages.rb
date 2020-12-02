class CreateChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_messages do |t|
      t.string :message, null: false
      t.references :user, foreign_key: true
      t.references :chat, foreign_key: true

      t.timestamps
    end
  end
end

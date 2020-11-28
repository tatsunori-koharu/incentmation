class CreateConsultationComments < ActiveRecord::Migration[6.0]
  def change
    create_table :consultation_comments do |t|
      t.text       :comment
      t.references :consultation, foreign_key: true 
      t.references :user,    foreign_key: true

      t.timestamps
    end
  end
end

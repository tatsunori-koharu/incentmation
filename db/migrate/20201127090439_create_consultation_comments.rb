class CreateConsultationComments < ActiveRecord::Migration[6.0]
  def change
    create_table :consultation_comments do |t|

      t.timestamps
    end
  end
end

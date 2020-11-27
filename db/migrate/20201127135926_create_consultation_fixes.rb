class CreateConsultationFixes < ActiveRecord::Migration[6.0]
  def change
    create_table :consultation_fixes do |t|
      t.references :user
      t.references :consultation

      t.timestamps
    end
  end
end

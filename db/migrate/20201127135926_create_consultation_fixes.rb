class CreateConsultationFixes < ActiveRecord::Migration[6.0]
  def change
    create_table :consultation_fixes do |t|

      t.timestamps
    end
  end
end

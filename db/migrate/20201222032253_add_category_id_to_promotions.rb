class AddCategoryIdToPromotions < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :category_id, :integer
  end
end

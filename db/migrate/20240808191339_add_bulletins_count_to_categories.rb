class AddBulletinsCountToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :bulletins_count, :integer
  end
end

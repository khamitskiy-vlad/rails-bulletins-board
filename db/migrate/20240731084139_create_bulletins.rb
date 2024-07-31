class CreateBulletins < ActiveRecord::Migration[7.1]
  def change
    create_table :bulletins do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.belongs_to :category, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end

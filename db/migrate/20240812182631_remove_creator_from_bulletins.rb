class RemoveCreatorFromBulletins < ActiveRecord::Migration[7.1]
  def change
    change_table :bulletins do |t|
      t.remove_references :creator
    end
  end
end

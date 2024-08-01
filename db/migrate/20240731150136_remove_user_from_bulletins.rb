class RemoveUserFromBulletins < ActiveRecord::Migration[7.1]
  def change
    remove_reference :bulletins, :user, null: false, foreign_key: true
    add_reference :bulletins, :creator, index: true, foreign_key: {to_table: :users}
  end
end

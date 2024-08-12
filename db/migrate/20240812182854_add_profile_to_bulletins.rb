class AddProfileToBulletins < ActiveRecord::Migration[7.1]
  def change
    add_reference :bulletins, :creator, null: false, index: true, foreign_key: {to_table: :profiles}
  end
end

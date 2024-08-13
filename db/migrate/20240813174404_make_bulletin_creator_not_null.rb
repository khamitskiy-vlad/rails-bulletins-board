class MakeBulletinCreatorNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :bulletins, :creator_id, false
  end
end

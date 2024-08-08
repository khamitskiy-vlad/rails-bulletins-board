class ResetAllCacheCounters < ActiveRecord::Migration[7.1]
  def up
    User.find_each do |user|
      User.reset_counters(user.id, :bulletins)
    end
  end
end

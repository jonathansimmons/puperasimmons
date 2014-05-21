class AddUidToActivites < ActiveRecord::Migration
  def change
    add_column :activities, :uid, :string
  end
end

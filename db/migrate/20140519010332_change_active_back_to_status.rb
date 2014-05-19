class ChangeActiveBackToStatus < ActiveRecord::Migration
  def change
  	rename_column :contacts, :active, :status
  end
end

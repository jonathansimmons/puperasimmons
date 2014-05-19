class ChangeStatusToActiveBooleanOnContacts < ActiveRecord::Migration
  def change
  	remove_column :contacts, :status
  	add_column :contacts, :active, :boolean, default: false
  end
end

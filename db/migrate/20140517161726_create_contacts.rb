class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :contact_type
      t.integer :transaction_type
      t.integer :status
      t.string :name
      t.string :email
      t.string :phone
      t.string :company
      t.string :street
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :service
      t.string :dot_loop_id
      t.text :notes
      t.string :uid

      t.timestamps
    end
  end
end

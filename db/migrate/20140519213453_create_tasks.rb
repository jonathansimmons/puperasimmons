class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :content
      t.boolean :completed
      t.datetime :due_date
      t.integer :contact_id
      t.integer :user_id
      t.integer :contact_sort
      t.integer :main_sort
      t.string :uid

      t.timestamps
    end
  end
end

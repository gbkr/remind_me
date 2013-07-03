class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.text :details
      t.integer :user_id
      t.index :user_id
      
      t.timestamps
    end
  end
end

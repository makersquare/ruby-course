class AddEventColumns < ActiveRecord::Migration
  def change
    drop_table :users
    drop_table :teams
    drop_table :events
    
    create_table :users do |t|
      t.string :name
    end
    
    create_table :teams do |t|
      t.string :name
    end
    
    create_table :events do |t|
      t.string :name, null: false
      t.timestamp :created_at
      t.integer :user_id
      t.integer :team_id      
    end 
  end
end

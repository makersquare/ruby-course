class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :name, :string
    end
    
    create_table :teams do |t|
      t.column :name, :string
    end
    
    create_table :events do |t|
      t.column :name, :string
      t.column :created_at, :timestamp
    end
    
  end

  def self.down
    drop_table :users
    drop_table :teams
    drop_table :events
  end
end

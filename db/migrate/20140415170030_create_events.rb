class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :content
      t.timestamp :created_at
      t.string :tags

      t.references :team
      t.references :user
    end
  end
end



class CreateEvent < ActiveRecord::Migration
  def change
      create_table :events do |t|
        t.string :name
        t.string :content
        t.references :user
        t.references :team
        t.timestamps
     end
  end
end

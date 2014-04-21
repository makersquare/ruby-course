class CreateTag < ActiveRecord::Migration
  def change
        create_table :tags do |t|
        t.references :event
        t.string :content
        t.timestamps
     end
  end
end

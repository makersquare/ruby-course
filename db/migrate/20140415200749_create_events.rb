class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :content
      t.text :tags
      t.references :user
      t.references :team
      t.timestamps
    end
  end
end


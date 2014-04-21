class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user
      t.references :team
      t.string :name
      t.string :content
      t.string :tags

      t.timestamps
    end
  end
end

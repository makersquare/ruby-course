class Tag < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag
      t.references :event
      t.timestamps
    end
  end
end

class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :tag

      t.references :event
    end
  end
end

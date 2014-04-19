class CreateEntities < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
    end

    create_table :teams do |t|
      t.string :name
    end

    create_table :events do |t|
      t.references :user
      t.references :team
      t.string  :name
      t.string  :content
      t.datetime :created_at
    end

    create_table :tags do |t|
      t.references :event
      t.string  :tag
    end
  end
end

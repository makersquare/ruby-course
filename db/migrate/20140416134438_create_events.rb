class CreateEvents < ActiveRecord::Migration
  def change
    # TODO
    create_table :events do |t|
      t.references :user
      t.references :team
      t.string :name
      t.string :content
      t.datetime :created_at
    end
  end
end

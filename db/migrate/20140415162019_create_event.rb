class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :team
      t.references :user
    end
  end
end

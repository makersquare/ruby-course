class AddEventTagJoin < ActiveRecord::Migration
  def change
    create_join_table :events, :tags
  end
end

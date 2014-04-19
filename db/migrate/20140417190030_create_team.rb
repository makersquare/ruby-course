class CreateTeam < ActiveRecord::Migration
  def change
    # TODO
    create_table :teams do |t|
    	t.string :name
    	t.datetime :created_at
    	t.datetime :updated_at
    end
  end
end

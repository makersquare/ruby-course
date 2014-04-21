class CreateTeams < ActiveRecord::Migration
  def change
    # TODO
    create_table :teams do |t|
      t.string :name
    end
  end
end

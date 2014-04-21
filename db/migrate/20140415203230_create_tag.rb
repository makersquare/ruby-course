class CreateTag < ActiveRecord::Migration
  def change
    # TODO
    create_table :tags do |t|
      t.string :name
    end
  end
end

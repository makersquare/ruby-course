class Timestamp < ActiveRecord::Migration
  def change
    # TODO
    create_table :timestamps do |t|
      t.string :name
      t.timestamps
    end
  end
end

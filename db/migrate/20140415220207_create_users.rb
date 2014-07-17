class CreateUsers < ActiveRecord::Migration
  def change
    # TODO
    create_table :users do |t|
    	t.string :name
    	t.references :posts
    end
  end
end

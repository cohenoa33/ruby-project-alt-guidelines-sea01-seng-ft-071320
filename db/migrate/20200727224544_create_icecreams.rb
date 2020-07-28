class CreateIcecreams < ActiveRecord::Migration[5.2]
  def change
    create_table :ice_creams do |t|
      t.string :name
      t.string :flavors
      t.string :toppings
    end
  end
end

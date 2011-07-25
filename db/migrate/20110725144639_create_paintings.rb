class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.string :name
      t.integer :height
      t.integer :width

      t.timestamps
    end
  end
end

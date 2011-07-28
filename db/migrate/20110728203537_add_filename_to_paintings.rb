class AddFilenameToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :filename, :string
  end
end

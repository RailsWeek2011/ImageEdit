class AddFormatToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :format, :string
  end
end

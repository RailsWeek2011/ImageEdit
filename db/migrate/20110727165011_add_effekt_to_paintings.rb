class AddEffektToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :effekt, :string
  end
end

class AddImgUrlToProducto < ActiveRecord::Migration
  def change
    add_column :producto, :img_url, :string
  end
end

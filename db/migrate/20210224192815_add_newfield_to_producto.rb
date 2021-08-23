class AddNewfieldToProducto < ActiveRecord::Migration
  def change
    add_reference :producto, :classification, index: true
  end
end

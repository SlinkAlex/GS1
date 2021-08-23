class AddRownIntoProdcuto < ActiveRecord::Migration
  def change
    add_column :producto, :origen, :integer, :default => 1
    #Ex:- :default =>''
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end

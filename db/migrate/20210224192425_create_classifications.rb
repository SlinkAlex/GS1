class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end

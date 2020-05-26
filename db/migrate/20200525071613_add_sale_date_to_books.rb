class AddSaleDateToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :sale_date, :date
  end
end

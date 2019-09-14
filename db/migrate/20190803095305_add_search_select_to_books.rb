class AddSearchSelectToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :search_select, :string
  end
end

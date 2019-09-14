class AddSearchToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :search, :string
  end
end

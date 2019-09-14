class AddSearchMethodToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :search_method, :string
  end
end

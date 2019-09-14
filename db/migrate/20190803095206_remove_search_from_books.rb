class RemoveSearchFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :search, :string
  end
end

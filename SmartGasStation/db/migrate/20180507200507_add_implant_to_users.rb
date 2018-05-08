class AddImplantToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :idImpianto, :string
  end
end

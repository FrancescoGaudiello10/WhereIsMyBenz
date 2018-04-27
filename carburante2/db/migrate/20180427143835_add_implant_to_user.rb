#lista degli impianti visitati dall'utente
class AddImplantToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :idImpianto, :text
  end
end

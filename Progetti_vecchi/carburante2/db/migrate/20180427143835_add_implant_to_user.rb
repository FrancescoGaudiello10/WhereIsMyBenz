#lista degli impianti visitati dall'utente (modellata come array)
class AddImplantToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :idImpianto, :text
  end
end

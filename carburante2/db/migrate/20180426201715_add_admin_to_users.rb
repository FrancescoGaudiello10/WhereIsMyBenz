# https://github.com/plataformatec/devise/wiki/How-To:-Add-an-Admin-Role#option-2-adding-an-admin-attribute
class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false
  end
end

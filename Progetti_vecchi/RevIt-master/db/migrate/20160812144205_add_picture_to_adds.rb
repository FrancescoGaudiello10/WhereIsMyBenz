class AddPictureToAdds < ActiveRecord::Migration
  def change
    add_column :adds, :picture, :string
  end
end

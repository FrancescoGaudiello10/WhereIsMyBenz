# commenti del gestore in una stazione
class CreateComments < ActiveRecord::Migration[5.2]
  def change

    create_table :comments do |t|

      t.string :commenter
      t.text :body
      t.integer :stars
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end

=begin
      The (:references) keyword used in the bash command is a special data type for models.
      It creates a new column on your database table with the provided model name appended
      with an _id that can hold integer values.
=end
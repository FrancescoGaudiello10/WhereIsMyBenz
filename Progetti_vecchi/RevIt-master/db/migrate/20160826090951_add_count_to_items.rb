class AddCountToItems < ActiveRecord::Migration
  def change
    add_column :items, :count, :integer , default: 0, index: true
  end
end

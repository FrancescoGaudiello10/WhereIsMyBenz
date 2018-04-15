class AddAttachmentImg1ToProperties < ActiveRecord::Migration[5.1]
  def self.up
    change_table :properties do |t|
      t.attachment :img1
      t.attachment :img2
      t.attachment :img3
    end
  end

  def self.down
    remove_attachment :properties, :img1
    remove_attachment :properties, :img2
    remove_attachment :properties, :img3
  end
end

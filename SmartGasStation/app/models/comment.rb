class Comment < ApplicationRecord
  # http://guides.rubyonrails.org/association_basics.html#polymorphic-associations
  #belongs_to :user
  belongs_to :commentable, polymorphic: true
end

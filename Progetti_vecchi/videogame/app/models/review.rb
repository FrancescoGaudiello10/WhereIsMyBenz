class Review < ActiveRecord::Base
    def self.all_rating ; [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] ; end

    validates :description, presence: true
    validates :rating, :inclusion => {:in => Review.all_rating}
    belongs_to :user
    belongs_to :game
    has_many :reports, :dependent => :destroy

    def self.search(target)
        where("rating LIKE ? ", target[:rating])
    end
end

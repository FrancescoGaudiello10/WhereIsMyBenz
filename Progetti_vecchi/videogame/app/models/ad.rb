class Ad < ActiveRecord::Base
    def self.all_type ; %w[Prestito Vendita] ; end

    validates :location, presence: true
    validates :delivery, presence: true
    validates :tipo, :inclusion => {:in => Ad.all_type}
    belongs_to :user
    belongs_to :game
    has_many :reports, :dependent => :destroy
    has_many :responses, :dependent => :destroy
end

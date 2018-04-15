class FixNomeAttributoTipoInAd < ActiveRecord::Migration
    def change
        change_table :ads do |t|
            t.remove :type
            t.string :tipo
        end
    end
end

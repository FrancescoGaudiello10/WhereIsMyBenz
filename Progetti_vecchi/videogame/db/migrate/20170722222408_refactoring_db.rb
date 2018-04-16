class RefactoringDb < ActiveRecord::Migration
    def change
        change_table :reports do |t|
            t.remove :reportable
            t.belongs_to :target_user, index: true
            t.belongs_to :game, index: true
            t.belongs_to :ad, index: true
            t.belongs_to :review, index: true
        end

        drop_table :reportables
    end
end

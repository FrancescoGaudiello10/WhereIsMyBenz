class RefactorYearToDate < ActiveRecord::Migration
    def change
        change_table :games do |t|
            t.remove :year
            t.date :year
        end
    end
end

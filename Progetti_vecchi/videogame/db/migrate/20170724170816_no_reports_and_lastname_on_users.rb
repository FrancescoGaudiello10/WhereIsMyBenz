class NoReportsAndLastnameOnUsers < ActiveRecord::Migration
    def change
        change_table :users do |t|
            t.remove :lastname
        end
        change_table :reports do |t|
            t.remove :target_user_id
        end
        remove_index :reports,:name => "index_reports_on_reportable_id"
    end
end

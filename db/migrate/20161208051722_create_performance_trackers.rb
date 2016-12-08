class CreatePerformanceTrackers < ActiveRecord::Migration[5.0]
  def change
    create_table :performance_trackers do |t|
      t.references :user, foreign_key: true
      t.references :invoice, foreign_key: true
      t.references :performance_category, foreign_key: true

      t.timestamps
    end
  end
end

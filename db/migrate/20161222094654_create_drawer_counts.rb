class CreateDrawerCounts < ActiveRecord::Migration[5.0]
  def change
    create_table :drawer_counts do |t|
      t.integer :ones
      t.integer :twos
      t.integer :fives
      t.integer :tens
      t.integer :twenties
      t.integer :fifties
      t.integer :hundreds
      t.decimal :total, :precision => 10, :scale => 2
      t.decimal :cash_total, :precision => 10, :scale => 2
      t.decimal :card_total, :precision => 10, :scale => 2
      t.text :note
      t.references :user, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end

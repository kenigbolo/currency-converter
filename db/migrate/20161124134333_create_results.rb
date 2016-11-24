class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.text :value
      t.references :calculation, foreign_key: true

      t.timestamps
    end
  end
end

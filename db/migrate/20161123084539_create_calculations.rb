# frozen_string_literal: true
class CreateCalculations < ActiveRecord::Migration[5.0]
  def change
    create_table :calculations do |t|
      t.string :base_currency
      t.string :conversion_currency
      t.float :amount
      t.float :current_rate
      t.integer :num_of_days
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

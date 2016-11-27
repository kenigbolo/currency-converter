# frozen_string_literal: true
# ! Migration file for OMniauth
class AddOmniauthToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end

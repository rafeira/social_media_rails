# frozen_string_literal: true

class CreateUserConnectionsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :user_connections do |t|
      t.integer :solicitor_user_id
      t.integer :requested_user_id
    end
    add_foreign_key :user_connections, :users, column: :solicitor_user_id, primary_key: 'id'
    add_foreign_key :user_connections, :users, column: :requested_user_id, primary_key: 'id'
  end
end

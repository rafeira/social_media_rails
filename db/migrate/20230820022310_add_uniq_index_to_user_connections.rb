# frozen_string_literal: true

class AddUniqIndexToUserConnections < ActiveRecord::Migration[7.0]
  def change
    add_index :user_connections, %i[solicitor_user_id requested_user_id], unique: true, name: 'unique_user_connections'
  end
end

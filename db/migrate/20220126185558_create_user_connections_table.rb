class CreateUserConnectionsTable < ActiveRecord::Migration[7.0]
  def change
    create_table "user_connections" do |t|
      t.integer :solicitor_user_id
      t.integer :requested_user_id
    end
  end
end

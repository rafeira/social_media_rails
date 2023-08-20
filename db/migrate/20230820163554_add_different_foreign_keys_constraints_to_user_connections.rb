class AddDifferentForeignKeysConstraintsToUserConnections < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE user_connections
      ADD CONSTRAINT check_different_foreign_keys
      CHECK (solicitor_user_id != requested_user_id);
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE user_connections
      DROP CONSTRAINT check_different_foreign_keys;
    SQL
  end
end

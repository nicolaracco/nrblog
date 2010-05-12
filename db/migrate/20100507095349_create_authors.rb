class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.database_authenticatable
      t.lockable
      t.recoverable
      t.rememberable
      t.trackable

      t.string :username, :null => false

      t.timestamps
    end
    add_index :authors, :username, :unique => true
  end

  def self.down
    drop_table :authors
  end
end

class AddPublicKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pub_key, :string
  end
end

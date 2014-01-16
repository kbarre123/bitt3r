class AddPublicKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pub_key, :text
  end
end

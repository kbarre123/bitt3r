class ChangePubKeyFromStringToText < ActiveRecord::Migration
  def up
    change_column :users, :pub_key, :text, :null=>true
  end
  def down
    change_column :users, :pub_key, :string
  end
end

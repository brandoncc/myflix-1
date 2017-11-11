class AddInvitorColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :invitor_token, :string
  end
end

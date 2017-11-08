class AddRandomTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    # not recommended
    # User.all.each do |user|
    #   user.set_token
    #   user.save
    # end
  end
end

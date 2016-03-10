class AddUserToGroups < ActiveRecord::Migration
  def change
    add_reference :groups, :user, index: true
    add_foreign_key :groups, :users
  end
end

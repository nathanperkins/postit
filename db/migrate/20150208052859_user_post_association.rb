class UserPostAssociation < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.references :user
    end

    add_foreign_key :posts, :users
  end
end

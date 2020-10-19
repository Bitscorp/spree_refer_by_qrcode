class AddReferTokenToSpreeUsers < SpreeExtension::Migration[6.0]
  def up
    add_column :spree_users, :refer_token, :string
    add_index :spree_users, :refer_token, unique: true

    ::Spree.user_class.find_each(&:regenerate_refer_token)
  end

  def down
    remove_index :spree_users, :refer_token
    remove_column :spree_users, :refer_token
  end
end
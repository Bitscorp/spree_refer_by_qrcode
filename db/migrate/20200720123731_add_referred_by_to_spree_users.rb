class AddReferredByToSpreeUsers < SpreeExtension::Migration[6.0]
  def change
    add_reference :spree_users, :referred_by
  end
end
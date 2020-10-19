# This migration comes from spree_refer_by_qrcode (originally 20200720123731)
class AddReferredByToSpreeUsers < SpreeExtension::Migration[6.0]
  def change
    add_reference :spree_users, :referred_by
  end
end
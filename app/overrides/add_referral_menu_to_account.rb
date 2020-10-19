Deface::Override.new(
  virtual_path: 'spree/users/show',
  name: 'add_referral_menu_to_account',
  insert_after: '[data-hook="account_my_orders"]',
  partial: 'spree/users/referral_menu'
)
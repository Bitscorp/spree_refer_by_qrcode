module SpreeReferByQrcode
  module Spree
    class QrCodeAbility
      include CanCan::Ability

      def initialize(user)
        # can show qrcode only for himself (admin manages all)
        if user.respond_to?(:has_spree_role?) && user.has_spree_role?('user')
          can :qr_code, ::Spree.user_class, id: user.id
        end
      end
    end
  end
end
module SpreeReferByQrcode
  module Spree
    module AbilityDecorator
      private

      def abilities_to_register
        super << SpreeReferByQrcode::Spree::QrCodeAbility
      end
    end
  end
end

if ::Spree::Ability.included_modules.exclude?(SpreeReferByQrcode::Spree::AbilityDecorator)
  ::Spree::Ability.prepend SpreeReferByQrcode::Spree::AbilityDecorator
end
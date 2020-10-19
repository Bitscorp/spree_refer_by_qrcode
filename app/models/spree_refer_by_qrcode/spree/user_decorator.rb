module SpreeReferByQrcode
  module Spree
    module UserDecorator
      def self.prepended(base)
        base.has_many :referrals, class_name: base.name, foreign_key: "referred_by_id"
        base.belongs_to :referrer, class_name: base.name, foreign_key: "referred_by_id", optional: true

        base.has_secure_token :refer_token
        # checks that record with that id exists
        base.validates :referrer, presence: true, if: :referred_by_id_present?
        # user cant refer himself
        base.validate :referrer_is_not_same_user, on: :update, if: :referred_by_id_present?
      end

      private

      def referred_by_id_present?
        self.referred_by_id.present?
      end

      def referrer_is_not_same_user
        if self.referred_by_id == self.id
          errors.add(:referred_by_id, :cant_refer_yourself)
        end
      end
    end
  end
end

if ::Spree.user_class.included_modules.exclude?(SpreeReferByQrcode::Spree::UserDecorator)
  ::Spree.user_class.prepend SpreeReferByQrcode::Spree::UserDecorator
end

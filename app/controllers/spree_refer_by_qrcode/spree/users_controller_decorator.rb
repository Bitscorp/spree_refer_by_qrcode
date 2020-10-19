module SpreeReferByQrcode
  module Spree
    module UsersControllerDecorator
      def show
        @qr = generate_qr_code(@user)
        @referrals = @user.referrals.page(params[:page]).per(5)
        @orders = @user.orders.complete.order('completed_at desc')
      end

      def qr_code
        @user = ::Spree.user_class.find(params[:id])
        raise ActiveRecord::RecordNotFound if @user.blank?

        authorize! :qr_code, @user
        render inline: generate_qr_code(@user).as_svg
      end

      private

      def generate_qr_code(user)
        if user.refer_token.blank?
          user.regenerate_refer_token
        end

        RQRCode::QRCode.new spree.signup_url(refer_token: user.refer_token)
      end
    end
  end
end

::Spree::UsersController.prepend SpreeReferByQrcode::Spree::UsersControllerDecorator if ::Spree::UsersController.included_modules.exclude?(SpreeReferByQrcode::Spree::UsersControllerDecorator)
module SpreeReferByQrcode
  module Spree
    module UserRegistrationsControllerDecorator
      def self.prepended(base)
        base.layout 'spree/layouts/new_login'
        base.before_action :check_refer_token, only: %i[new]
      end

      def create
        @referrer = ::Spree.user_class.find_by(refer_token: params[:refer_token])
        if @referrer.blank?
          set_flash_message :alert, :refer_token_is_wrong
          render :new
          return
        end

        @user = build_resource(spree_user_params.merge(referrer: @referrer))
        resource_saved = resource.save
        yield resource if block_given?
        if resource_saved
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up
            sign_up(resource_name, resource)
            session[:spree_user_signup] = true
            redirect_to_checkout_or_account_path(resource)
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}"
            expire_data_after_sign_in!
            respond_with resource, location: after_inactive_sign_up_path_for(resource)
          end
        else
          clean_up_passwords(resource)
          render :new
        end
      end

      def check_refer_token
        if params[:refer_token].blank?
          raise ActionController::RoutingError.new('Not Found')
        end

        @referrer = ::Spree.user_class.find_by(refer_token: params[:refer_token])
        if @referrer.blank?
          set_flash_message :alert, :refer_token_is_wrong
          redirect_to root_path and return
        end
      end
    end
  end
end

::Spree::UserRegistrationsController.prepend SpreeReferByQrcode::Spree::UserRegistrationsControllerDecorator if ::Spree::UserRegistrationsController.included_modules.exclude?(SpreeReferByQrcode::Spree::UserRegistrationsControllerDecorator)

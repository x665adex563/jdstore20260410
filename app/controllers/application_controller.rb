class ApplicationController < ActionController::Base
  before_action :set_locale
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_cart

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def set_locale
    I18n.locale =
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        params[:locale].to_sym
      else
        I18n.default_locale
      end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def admin_required
    if !current_user.admin?
      redirect_to "/", alert: t("admin.flash.not_admin")
    end
  end

  def current_cart
    @current_cart ||= find_cart
  end

  private

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    if cart.blank?
      cart = Cart.create
    end
    session[:cart_id] = cart.id
    return cart
  end
end

class ApplicationController < ActionController::Base
  before_action :set_locale
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

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
end

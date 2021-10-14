module StaticPagesHelper
  def get_request_path_without_locale
    return request.path if params[:locale].nil?

    path = request.path.split("/")
    path = path.reject{|e| I18n.available_locales.include? e.to_sym}
    path.join("/")
  end

  def add_locale_to_request_path locale = ""
    # remove current locale and return a current path with new locale inserted
    locale.to_s.prepend("/").concat(get_request_path_without_locale)
  end
end

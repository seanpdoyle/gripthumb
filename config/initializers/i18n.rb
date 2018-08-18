if Rails.env.development? || Rails.env.test?
  I18n.exception_handler = lambda do |_exception, locale, key, options|
    raise I18n::MissingTranslationData.new(locale, key, options)
  end
end

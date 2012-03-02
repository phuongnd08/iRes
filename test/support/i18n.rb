class TestExceptionLocalizationHandler
  def call(exception, locale, key, options)
    raise "Translation for [#{locale}]#{key} does not exist"
  end
end

I18n.exception_handler = TestExceptionLocalizationHandler.new

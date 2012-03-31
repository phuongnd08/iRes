class TestExceptionLocalizationHandler
  def red(text)
    "\033[31m#{text}\033[0m"
  end

  def bold(text)
    "\033[01m#{text}\033[00m"
  end

  def call(exception, locale, key, options)
    msg = "Translation for [#{locale}]#{key} does not exist"
    Rails.logger.error("[#{bold(red('ERROR'))}] #{msg}")
    raise msg
  end
end

I18n.exception_handler = TestExceptionLocalizationHandler.new

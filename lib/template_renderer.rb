class TemplateRenderer < AbstractController::Base
  include AbstractController::Rendering
  include AbstractController::Helpers
  include AbstractController::Translation
  include AbstractController::AssetPaths
  self.view_paths = "app/views"

  #provide logger incase of template syntax error
  def logger
    Rails.logger
  end

  class << self
    attr_accessor :full_host

    def instance
      @instance ||= self.new
    end

    def render template, locals = {}
      instance.render :partial => template, :locals => locals
    end
  end
end

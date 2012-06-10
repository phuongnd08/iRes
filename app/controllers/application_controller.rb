class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_layout

  before_filter :store_pubsub_server_address

  if Rails.env.development?
    prepend_before_filter lambda { I18n.reload! }
  end

  private
  def set_layout
    if request.get? && request.xhr?
      self.class.layout false
    else
      self.class.layout 'application'
    end
  end

  def store_pubsub_server_address
    PubSub.current_host = request.host
  end

end

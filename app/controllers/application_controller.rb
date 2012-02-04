class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_layout

  private
  def set_layout
    if request.get? && request.xhr?
      self.class.layout false
    else
      self.class.layout 'application'
    end
  end
end

class HomeController < ApplicationController
  before_filter :load_role

  def waiter; end

  def chef; end

  def manager; end

  private
  def load_role
    @role = params[:action].to_inquirer
  end
end

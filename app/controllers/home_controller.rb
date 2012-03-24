class HomeController < ApplicationController
  before_filter :load_role, :only => [:waiter, :chef, :manager]

  def waiter; end

  def chef; end

  def manager; end

  def emulator
    @role = params[:role].to_inquirer
    @bare = params[:bare].present?
    render :layout => nil
  end

  def demo
    render :layout => nil
  end

  private
  def load_role
    @role = params[:action].to_inquirer
  end
end

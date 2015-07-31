class HomeController < ApplicationController
  def index
    @users = User.all
    render 'index'
  end
end

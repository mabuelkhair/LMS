class UserController < ApplicationController
  before_action :authenticate_user!
  def user
  end

  def profile

  end

  def follow
  end

  def unfollow
  end
end

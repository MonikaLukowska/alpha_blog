# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update distroy]
  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your account was successfully updated'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

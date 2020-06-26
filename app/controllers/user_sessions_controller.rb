class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to(root_url, notice: 'Login successful')
    else
      flash.alert = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(root_url, notice: 'Logged out')
  end
end

class UsersController < ApplicationController

  def create
    u = User.new(id: SecureRandom.uuid)
    if u.update(user_params)
      render json: {}, status: 200
    else
      render json: {error: u.errors.full_messages[0].to_s}, status: 401
    end
  end

  private
  def user_params
    params.require(:user).permit(:first, :last, :email, :password)
  end
end

class UserController < ApplicationController
  def all
	@users=User.all 
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to "user/all" }
    end
  end

end

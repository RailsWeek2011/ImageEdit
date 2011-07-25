class UserController < ApplicationController
  def all
	@users=User.all 
  end
  def update
  	@user = User.find(params[:id])
     	if @user.update_attributes(params[:user])
  		# success
  		redirect_to :action => 'all'
  	else
  		redirect_to :action => 'edit'
	end
  	@user.save

  end
  def edit
  	@user=User.find(params[:id])
  
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
	 redirect_to :action => 'all'
  end

end#
#
#
#


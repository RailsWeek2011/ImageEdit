class UsersController < ApplicationController
  def all
	@users=User.all 
  end
  
  def someaction
  end
  def update
  	@user=User.find(params[:id])
  	if @user.update_attributes(params[:user])
  		redirect_to :action => 'all'
  		@user.save
  	else
  		redirect_to :action => 'edit'
	end
  end
  def paintings
	@users=User.where(:admin => false)
  end
  def edit
  	@user=User.find(params[:id])
  
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
	 redirect_to :action => 'all'
  end

end

class UsersController < ApplicationController
  def all
	@users=User.all 
  end
  
  def someaction
  end
  def update
  	@user=User.find(params[:id])
  	if @user.update_attributes(params[:usertmp])
		if params[:admin]
			@user.make_admin
  		else
			@user.make_user
  		end
  		@user.save
  		p=User.find(params[:aid])
  		if(p.admin)
			redirect_to :action => 'all'
  		else
			redirect_to :action=> 'edit'
  		end

  	else
  		redirect_to :action => 'edit'
	end
  end
  def paints
	@onlyusers=User.where(:admin => false)
  end
  def edit
	 @usertmp=User.find(params[:id])
	 @admin=User.find(params[:aid])
  	
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
	 redirect_to :action => 'all'
  end

end

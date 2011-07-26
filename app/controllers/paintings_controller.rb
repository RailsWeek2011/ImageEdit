class PaintingsController < ApplicationController
  before_filter :authenticate_user!
	def upload
        @painting = Painting.new
	end
	def download
		tmp =Painting.find(params[:id])
		send_file tmp.image.to_s, :type=>"application/zip", :x_sendfile=>true
		
	end
	def edit
		@painting = Painting.find(params[:id])
	end
	def format
		p=Painting.find(params[:id])
		p.update_attributes(params[:painting])
		tmp=p.image
		p.remove_image
		tmp.resize_to_fit(p.width,p.height)
		#tmp.format(:format)
		p.image=tmp
		p.save
		redirect_to :action => 'showall'
	end
	def create
		@painting=Painting.new params[:painting]
        @painting.user = current_user
		if @painting.save 
			redirect_to :action => 'showall'
		else
			render :action => 'upload'
		end
	end

	def showall
		@paintings=Painting.where("user_id=#{params[:id]}")
	end
	def delete
		p=Painting.find(params[:pid])
		p.remove_image
		if p.destroy
			redirect_to :action =>'showall'
		else
		end
	end
end

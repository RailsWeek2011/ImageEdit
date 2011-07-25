class PaintingController < ApplicationController
	def upload
	end
	def create
		p=Painting.new(:user_id=>params[:id])
		p.update_attributes(params[:painting])
		redirect_to :action => 'showall'	
	end
	def showall
		@paintings=Painting.where("user_id=#{params[:id]}")
	end
end

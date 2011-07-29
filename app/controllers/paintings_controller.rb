class PaintingsController < ApplicationController
  require 'RMagick'
include Magick
  
  before_filter :authenticate_user!
	def upload
        @painting = Painting.new
	end

	def download
		tmp =Painting.find(params[:id])
		send_file "#{Rails.root}/public/uploads/painting/image/#{tmp.id}/#{tmp.filename.to_s.split('.').first}#{'.'}#{tmp.format}"
	end
	def edit
		@painting = Painting.find(params[:id])
		img = Image.read("#{Rails.root}/public/uploads/painting/image/#{@painting.id}/#{@painting.filename.to_s.split('.').first}#{'.'}#{@painting.format}").first
		@painting.width=img.rows
		@painting.height=img.columns
		@painting.format=@painting.filename.to_s.split('.').last
		@painting.save
		
	end
	def format
		p=Painting.find(params[:id])
		@oldf=p.format			
		p.update_attributes(params[:painting])
		img = Image.read("#{Rails.root}/public/uploads/painting/image/#{p.id}/#{p.filename.to_s.split('.').first}#{'.'}#{@oldf}").first
		img = img.resize_to_fit(p.width.to_i,p.height.to_i)
		thumb_file =  "thumb_#{p.image.to_s.split("/").last}"
        slash = "/"
        thumb_path = File::expand_path(File::dirname("#{Rails.root}/public/#{p.image.to_s}"))
        thumb = Image.read("#{thumb_path}#{slash}#{thumb_file}")
        
        if p.effekt === "none"
        puts "lol" 
        end
        if p.effekt === 'vignette'
            img = img.vignette
        end      
        if p.effekt === 'edge'
            img = img.edge(8)
        end
        if p.effekt === 'polaroid'
            cols, rows = img.columns, img.rows
            img[:caption] = p.name
            img = img.polaroid{ self.gravity = Magick::CenterGravity }
            img.change_geometry!("#{cols}x#{rows}") do |ncols,nrows,img|
            img.resize!(ncols,nrows)
            end
        end
        if p.effekt === 'emboss'
            img = img.emboss
        end
        if p.effekt === 'implode'
            img = img.implode(0.4)
        end
        if p.effekt === 'negate'
            img = img.negate
        end
        if p.effekt === 'oil'
             img = img.oil_paint
        end
        if p.effekt === 'spread'
            img = img.spread
        end
        if p.effekt === 'wave'
            img = img.wave(10,200)
        end     
        if (p.format.to_s === @oldf.to_s)
			img.write("#{Rails.root}/public/uploads/painting/image/#{p.id}/#{p.filename.to_s.split('.').first}#{'.'}#{p.format}")
			p.image.recreate_versions!
        else
			img.write("#{Rails.root}/public/uploads/painting/image/#{p.id}/#{p.filename.to_s.split('.').first}#{'.'}#{p.format}")
			p.image.convert("#{p.format}") 
			p.image= ImageUploader.new "#{Rails.root}/public/uploads/painting/image/#{p.id}/#{p.filename.to_s.split('.').first}#{'.'}#{p.format}"
			p.image.recreate_versions!
			p.filename = "#{p.filename.to_s.split('.').first}#{'.'}#{p.format}"
			File::delete("#{Rails.root}/public/uploads/painting/image/#{p.id}/#{p.filename.to_s.split('.').first}#{'.'}#{@oldf}" )		
        end
        p.save
		redirect_to :action => 'showall', :id => current_user
	end
	def create
		@painting=Painting.new params[:painting]
        @painting.user = current_user
        @painting.filename=@painting.image.filename
        @painting.format=@painting.filename.to_s.split(".").last
			 
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
		require 'fileutils'
  					File::delete("#{Rails.root}/public/uploads/painting/image/#{p.id}/#{p.filename.to_s.split('.').first}#{'.'}#{p.format}" )
  		FileUtils.rm_rf "uploads/painting/image/#{p.id}/"
		
		p.remove_image
		
		if p.destroy
			redirect_to :action => 'showall'
		end
	end
end

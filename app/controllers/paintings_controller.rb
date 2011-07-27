class PaintingsController < ApplicationController
  require 'RMagick'
include Magick
  
  before_filter :authenticate_user!
	def upload
        @painting = Painting.new
	end

	def download
		tmp =Painting.find(params[:id])
		send_file "#{Rails.root}/public/#{tmp.image.to_s}"
		#redirect_to :action =>	'showall'	
	end
	def edit
		@painting = Painting.find(params[:id])
	end
	def format
        
		p=Painting.find(params[:id])
		p.update_attributes(params[:painting])
		p.image = p.image.resize_to_fill(p.width.to_i,p.height.to_i)
        
		img = Image.read("#{Rails.root}/public/#{p.image.to_s}").first
        thumb_file =  "thumb_#{p.image.to_s.split("/").last}"
        slash = "/"
        thumb_path = File::expand_path(File::dirname("#{Rails.root}/public/#{p.image.to_s}"))
        thumb = Image.read("#{thumb_path}#{slash}#{thumb_file}")
        
        if p.effekt === "none"
        puts "lol" 
        end

        if p.effekt === 'vignette'
            #thumb = thumb.vignette
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
        
        if p.format === 'JPG'
        img.write("#{Rails.root}/public/#{p.image.to_s.split('.').first}#{'.jpg'}")
        File::delete("#{Rails.root}/public/#{p.image.to_s}")
        tmp = p.image.to_s.split('.').first
        tmp = tmp.split('/').last
        tmp = tmp#{'.gif'}
        write_attribute(:image => tmp.to_s)
        end
        if p.format === 'PNG'
        img.write("#{Rails.root}/public/#{p.image.to_s.split('.').first}#{'.png'}")
        File::delete("#{Rails.root}/public/#{p.image.to_s}")
        tmp = p.image.to_s.split('.').first
        tmp = tmp.split('/').last
        tmp = tmp#{'.gif'}
        write_attribute(:image => tmp.to_s)
        end
        if p.format === 'GIF'
        img.write("#{Rails.root}/public/#{p.image.to_s.split('.').first}#{'.gif'}")
        File::delete("#{Rails.root}/public/#{p.image.to_s}")
        tmp = p.image.to_s.split('.').first
        tmp = tmp.split('/').last
        tmp = tmp#{'.gif'}
        write_attribute(:image => tmp.to_s)
        end     
		#p.update_attributes(params[:painting])
#        p.save
   
                #img.write(thumb_path)
        
		redirect_to :action => 'showall', :id => current_user
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
			redirect_to :action => 'showall'
		end
	end
end

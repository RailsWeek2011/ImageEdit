class Painting < ActiveRecord::Base
	attr_accessible :name , :image,:painting,:paintings, :width, :height, :format, :effekt, :filename
	belongs_to :user
	mount_uploader :image, ImageUploader
	
end

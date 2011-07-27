class Painting < ActiveRecord::Base
	attr_accessible :name , :image,:painting,:paintings, :width, :height, :format, :effekt
	belongs_to :user
	mount_uploader :image, ImageUploader
end

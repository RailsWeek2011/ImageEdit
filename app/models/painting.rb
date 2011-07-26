class Painting < ActiveRecord::Base
attr_accessible :name , :image,:painting,:paintings,:width,:height
	
belongs_to :user #, :foreign_key => "user_id"
mount_uploader :image, ImageUploader
end

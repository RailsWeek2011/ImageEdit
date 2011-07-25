class Painting < ActiveRecord::Base
attr_accessible :name , :image,:painting,:paintings
	
belongs_to :user, :foreign_key => "user_id"
mount_uploader :image, ImageUploader
end

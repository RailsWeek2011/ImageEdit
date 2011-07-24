class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
 after_initialize :default_values

 
    def default_values
      self.admin ||= false
    end
  
 # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :admin, :password, :password_confirmation, :remember_me
	 
	def make_admin
		self.admin = true
		self.save
		return true
	end
end

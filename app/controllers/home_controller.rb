class HomeController < ApplicationController
# projects_controller.rb ##danke hab gesucht ^^	
	before_filter :authenticate_user!, :except => [:show, :index]
	 
  def index
  end

end

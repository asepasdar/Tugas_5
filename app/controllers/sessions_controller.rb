class SessionsController < Devise::SessionsController
	def new
		super
	end
  def create
    @user = User.find_by_username(params[:username])
    if @user != nil
    	redirect_to root_path
    else
        super
    end
  end
end 
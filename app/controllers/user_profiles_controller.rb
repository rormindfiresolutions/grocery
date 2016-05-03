class UserProfilesController < ApplicationController
	before_action :authenticate_user!
	
	def new
		@detail = UserProfile.new
	end

	def create
		@detail = current_user.build_user_profile(user_params)
		if UserProfile.all_blank(@detail)
			flash[:error] = 'All field are blank'
			render 'new'
		elsif @detail.save
			flash[:success] = 'User details added'
			redirect_to root_path
		else
			render 'new'
		end
	end

	private
		def user_params
			params.require(:user_profile).permit(:first_name, :last_name, :phone_number, :email)
		end
end
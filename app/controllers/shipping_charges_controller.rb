class ShippingChargesController < ApplicationController
	def new
		@shipping_charge = ShippingCharge.new
		@shop = ShopProfile.find(params[:shop_profile_id])
		@shipping_charges = @shop.shipping_charges
	end

	def edit
		@shop = ShopProfile.find(params[:shop_profile_id])
		@shipping_charge = ShippingCharge.find(params[:id])
	end

	def create
		shop = ShopProfile.find(params[:shop_profile_id])
		shipping_charge = shop.shipping_charges.build(shipping_charge_params)
		if shipping_charge.save
			flash[:success] = "Added Successfully"
		else
			flash[:danger] = "Error While Adding"
		end
		redirect_to request.referer || root_path
	end

	def update
		@shop = ShopProfile.find(params[:shop_profile_id])
		@shipping_charge = ShippingCharge.find(params[:id])
		if @shipping_charge.update_attributes(shipping_charge_params)
			flash[:success] = 'Updated Successfully'
			redirect_to request.referer || root_path
		else
			flash[:danger] = 'It is not Updated'
			redirect_to request.referer || root_path
		end

	end

	def destroy
		@shipping_charge = ShippingCharge.find(params[:id])
		if @shipping_charge.destroy
		  flash[:success] = "Removed Successfully"
		  redirect_to request.referrer || root_path
		else
			flash[:danger] = "Error While Removing"
			redirect_to request.referrer || root_path
		end	 
	end

	def reset
		@shop = ShopProfile.find(params[:shop_profile_id])
		if @shop.shipping_charges.destroy_all
		  flash[:success] = "Removed Successfully"
		  redirect_to shop_profiles_path
		else
			flash[:danger] = "Error While Removing"
			redirect_to request.referrer || root_path
		end	 
	end


	private

		def shipping_charge_params
			params.require(:shipping_charge).permit(:minimum_order_cost,:maximum_order_cost,:shipping_cost)
		end

end
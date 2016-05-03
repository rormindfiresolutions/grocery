class Product < ActiveRecord::Base
	has_many :shop_products
	belongs_to :brand
	belongs_to :category

	def self.search(search)
	  if search
	    where("product_name like ?", "%#{search}%")
	  else
	    all
	  end
	end

	# To change the Approval status of a Product by Admin
	def self.approval_status(item, flash)
		unless item.is_approved
 	  	item.is_approved = true
 	  	item.save 
 	  	flash[:success] = 'Approved'	 	  	
	 	else
 	  	item.is_approved = false
 	  	item.save 
 	  	flash[:danger] = 'Not Approved'
	 	end
	end

	# To change the Activation status of a Product by Admin
	def self.activation_status(item, flash)
		if ! item.is_active
 	  	item.is_active = true
 	  	item.save 
 	  	flash[:success] = 'Activated'
 	  else
 	  	item.is_active = false
 	  	item.save 
 	  	flash[:warning] = 'Deactivated'
 	  end
 	end

end

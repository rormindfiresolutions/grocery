class UserProfile < ActiveRecord::Base
	belongs_to :user

	nilify_blanks only: [:first_name, :last_name, :phone_number, :email]

	VALID_NAME_REGEX = /\A[a-zA-Z]+\z/

	with_options if: :is_customer? do |customer|
    customer.validates :first_name, length: { minimum: 3, maximum: 30 }, 
    format: { with: VALID_NAME_REGEX }, allow_blank: true
    customer.validates :last_name, length: { minimum: 3, maximum: 30 },
    format: { with: VALID_NAME_REGEX }, allow_blank: true
    customer.validates :phone_number, length: { is: 10 }, numericality: { only_integer: true }, 
    allow_blank: true
    customer.validates_format_of :email, with: Devise::email_regexp, allow_blank: true
  end

  def is_customer?
  	user.role == 'customer'
  end

  with_options if: :is_shopkeeper? do |shopkeeper|
    shopkeeper.validates :first_name, length: { minimum: 3, maximum: 30 }, 
    format: { with: VALID_NAME_REGEX }
    shopkeeper.validates :last_name, length: { minimum: 3, maximum: 30 }, 
    format: { with: VALID_NAME_REGEX }
    shopkeeper.validates :phone_number, length: { is: 10 }, numericality: { only_integer: true }
    shopkeeper.validates_format_of :email, with: Devise::email_regexp, allow_blank: true
  end

  def is_shopkeeper?
  	user.role == 'shopkeeper'
  end

  def self.all_blank(user)
  	if user.attributes.all?{|k,v| v.blank? || %w(id user_id).include?(k)}
  		return true
  	else
  		return false
  	end
	end
  
end

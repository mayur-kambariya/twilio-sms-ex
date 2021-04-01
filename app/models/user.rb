class User < ActiveRecord::Base
  # attr_accessible :email, :name, :phone
  
  validates :name, presence: true
  validates :phone, presence: true
end

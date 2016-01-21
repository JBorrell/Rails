class Review < ActiveRecord::Base
	validates :user, uniqueness: { scope: :restaurant, message: "Restaurant already reviewed" }
	validates :rating, inclusion: (1..5)
	belongs_to :restaurant
	belongs_to :user
end

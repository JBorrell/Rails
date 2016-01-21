class ReviewsController < ApplicationController
	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
	end

	def create 
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = @restaurant.build_review review_params, current_user

		if @review.save
			redirect_to restaurants_path
		else
			if @review.errors[:user]
			redirect_to restaurants_path, alert:  'Restaurant already reviewed'
			else
				render :new
		end
	end
	end

	def destroy
		@review = Review.find_by(restaurant_id: params[:restaurant_id], user_id: params[:id])
		@review.destroy
		flash[:notice] = 'Review deleted successfully'
		redirect_to '/restaurants'
	end

	def review_params
		params.require(:review).permit(:thoughts, :rating)
	end
end

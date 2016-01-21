require 'spec_helper'

describe Restaurant, type: :model do
	it {is_expected.to have_many :reviews}

	it 'is not valid with a name of less that three characters' do
		restaurant = Restaurant.new(name: "kf")
		expect(restaurant).to have(1).error_on(:name)
		expect(restaurant).not_to be_valid
	end

	it 'is not valid unless it has a unique name' do
		Restaurant.create(name: "Moe's Tavern")
		restaurant = Restaurant.new(name: "Moe's Tavern")
		expect(restaurant).to have(1).error_on(:name)
	end

	describe '#average_rating' do
		context 'no reviews' do
			it 'returns "N/A" when there are no reviews' do
				restaurant = Restaurant.new(name: 'The Ivy')
				expect(restaurant.average_rating).to eq 'N/A'
			end
		end
		context '1 review' do
			it 'returns that rating' do
				restaurant = Restaurant.create(name: 'The Ivy')
				restaurant.reviews.create(rating: 4)
				expect(restaurant.average_rating).to eq 4
			end
		end
		context 'multiple reviews' do
			it 'returns the average rating' do
				restaurant = Restaurant.create(name: 'The Ivy')
				restaurant.reviews.create(rating: 3)
				restaurant.reviews.create(rating: 5)
				expect(restaurant.average_rating).to eq 4
			end
		end
	end

end

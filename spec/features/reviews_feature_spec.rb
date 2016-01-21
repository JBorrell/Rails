require 'rails_helper'

feature 'reviewing' do
	before do
			sign_in_user
			add_restaurant
			leave_review
	end


	    scenario 'allows users to leave a review using a form' do
        expect(current_path).to eq '/restaurants'
        expect(page).to have_content('so so')
      end
	    
	    scenario 'deletes reviews of restaurant if deleted' do
	      click_link 'Delete Wendys'
	      expect(Review.all).to eq([])
	    end

			scenario "User cant leave multiple reviews on the same restaurant" do
				click_link 'Review Wendys'
				fill_in 'Thoughts', with: 'Grrrreeeaaaattt!'
				select '5', from: 'Rating'
				click_button 'Leave Review'
				expect(page).not_to have_content('Grrrreeeaaaattt!')
				expect(page).to have_content('Restaurant already reviewed')
			end

			context 'Deleting reviews' do
					scenario 'user can delete their own review' do
						click_link 'Wendys'
						click_link 'Delete My Review'
						expect(page).not_to have_content('so so')
					end

					scenario 'user cannot delete other users review' do
						click_link 'Sign out'
						sign_in_user("Billy@hotmail.com")
						click_link 'Wendys'
						expect(page).not_to have_link('Delete My Review')
					end	

			end

			context 'Average ratings' do
				scenario 'displays an average rating for all reviews' do
					click_link 'Sign out'
					sign_in_user("Billy@hotmail.com")
					leave_review("GREAT", 5)
					expect(page).to have_content('Average rating: ★★★★☆')
				end
					
			end


end

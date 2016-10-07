require 'rails_helper'

feature 'reviewing' do

  context 'creating a review' do
  # before { Restaurant.create(name: 'KFC')}
    before do
      sign_up_1
      add_restaurant
    end

    scenario 'user adds a review to their restaurant, then review is displayed' do
      leave_review
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content "5 star dining at it's best"
    end

    scenario "user cannot add two reviews to one of their restaurants" do
      leave_review
      leave_review
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content "You have already reviewed this restaurant"
    end
  end

    context "anonymous user" do
      scenario "cannot add a review" do
        sign_up_1
        add_restaurant
        click_link('Sign out')
        leave_review
        expect(page).to have_content "You must sign in before leaving a review"
      end
    end

    #   # scenario 'displays an average rating for all reviews' do
    #   #   leave_review('So so', '3')
    #   #   leave_review('Great', '5')
    #   #   expect(page).to have_content('Average rating: 4')
    #   # end
    #
    end

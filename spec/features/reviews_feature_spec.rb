require 'rails_helper'

feature 'reviewing' do

  context 'creating a review' do
  # before { Restaurant.create(name: 'KFC')}
    before do
      visit '/'
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
      click_link('Add a restaurant')
      fill_in('Name', with: 'KFC')
      click_button('Create Restaurant')
    end

    scenario 'user adds a review to their restaurant, then review is displayed' do
      click_link('Review KFC')
      fill_in('Comments', with: "5 star dining at it's best")
      select '5', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content "5 star dining at it's best"
    # scenario 'allows user to leave review using a form' do
    #   visit '/restaurants'
    #   click_link 'Review KFC'
    #   fill_in('Comments', with: "5 star dining at it's best")
    #   select '5', from: 'Rating'
    #   click_button 'Leave Review'
    #   expect(current_path).to eq '/restaurants'
    #   expect(page).to have_content "5 star dining at it's best"
    # end
    end

    scenario "user cannot add two reviews to one of their restaurants" do
      click_link('Review KFC')
      fill_in('Comments', with: "Greasy horrible food")
      select '1', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content "You have already reviewed this restaurant"
    end

    # scenario "user cannot edit a review that they haven't added" do
    #
    # end
    #
    # scenario "user cannot delete a review that they haven't added" do
    #
    # end


  end
end

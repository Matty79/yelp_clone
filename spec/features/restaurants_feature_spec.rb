require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit('/restaurants')
      expect(page).to have_content('No restaurants yet')
      expect(page).to have_link('Add a restaurant')
    end
  end

  context 'creating restaurants' do
    before do
      sign_up_1
    end
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      add_restaurant
      expect(current_path).to eq('/restaurants')
      expect(page).not_to have_content('No restaurants yet')
      expect(page).to have_content('KFC')
    end

    scenario 'anonymous user is not allowed to create a restaurant' do
      Capybara.reset_sessions!
      visit('/restaurants')
      click_link("Add a restaurant")
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        visit('/restaurants')
        click_link('Add a restaurant')
        fill_in('Name', with: 'kf')
        click_button('Create Restaurant')
        expect(page).not_to have_css('h2', text: 'kf')
        expect(page).to have_content('error')
      end
    end
  end

  context 'viewing restaurants' do
    let!(:kfc) { Restaurant.create(name: 'KFC') }
    scenario 'lets anonymous user view a restaurant' do
      visit('/restaurants')
      click_link('KFC')
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before do
      sign_up_1
      add_restaurant
    end
    scenario 'let a user edit a restaurant' do
      edit_restaurant
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'heart-attack in a bucket'
      expect(current_path).to eq '/restaurants'
    end

    scenario "user cannot edit a restaurant they haven't added" do
      click_link('Sign out')
      sign_up_2
      expect(page).to have_content('KFC')
      edit_restaurant
      expect(page).to have_content 'Sorry, you can only edit your own restaurants'
    end
  end

  context 'deleting restaurants' do
    before do
      sign_up_1
      add_restaurant
    end
    scenario 'removes restaurant when user clicks delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario "user cannot delete a restaurant they haven't added" do
      visit '/'
      click_link('Sign out')
      sign_up_2
      expect(page).to have_content('KFC')
      click_link('Delete KFC')
      expect(page).to have_content 'Sorry, you can only delete your own restaurants'
    end
  end

end

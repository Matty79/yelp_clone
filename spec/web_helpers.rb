
def sign_up_1
  visit '/'
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def sign_up_2
  visit '/'
  click_link('Sign up')
  fill_in('Email', with: 'test1@example.com')
  fill_in('Password', with: 'happier')
  fill_in('Password confirmation', with: 'happier')
  click_button('Sign up')
end

def add_restaurant
  click_link('Add a restaurant')
  fill_in('Name', with: 'KFC')
  click_button('Create Restaurant')
end

def edit_restaurant
  visit('/')
  click_link('Edit KFC')
  fill_in('Name', with: 'Kentucky Fried Chicken')
  fill_in('Description', with: 'heart-attack in a bucket')
  click_button('Update Restaurant')
end

def leave_review
  click_link('Review KFC')
  fill_in('Comments', with: "5 star dining at it's best")
  select '5', from: 'Rating'
  click_button 'Leave Review'
end

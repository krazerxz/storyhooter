Given 'there are some users in the database' do
  user_1 = User.create(tale: 'beginning')
  user_2 = User.create(tale: 'middle')
  user_3 = User.create(tale: 'end')

  user_1.add_child user_2
  user_2.add_child user_3

  user_2.add_parent user_1
  user_3.add_parent user_2
end

When 'I visit the homepage' do
  visit '/'
end

Then 'I should see the homepage' do
  # Total users
  expect(find('#users').text).to match(/3/)

  # Example Story
  expect(find('#example-story').text).to match(/beginning middle end/)
end

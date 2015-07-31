Given 'there are some users in the database' do
  User.create
  User.create
end

When 'I visit the homepage' do
  visit '/'
end

Then 'I should see user statistics' do
  expect(find('#users').text).to match(/2/)
end

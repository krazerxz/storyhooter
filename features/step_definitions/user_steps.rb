Given 'there is an existing completed user' do
  User.create(name: 'primary_user', tale: 'Once upon a time', completed: true)
end

When 'I visit the new user page with the existing user uuid' do
  user = User.all.first
  visit "/user/new?referred_from=#{user.uuid}"
end

Then 'I should see the new user page' do
  expect(find('#referred-from').text).to match(/primary_user/)
  # expect(find('#story-so-far').text).to match(/Once upon a time/)
end

When 'I fill in details for the new user' do
  fill_in('user_nickname', with: 'username')
  select('United Kingdom', from: 'user_country_id')
  fill_in('user_tale', with: 'The End')
end

Then 'I see the user show page' do
  User.find_by(name: 'username').uuid
  expect(find('#user-count').text).to match(/2/)
  expect(find('#referral-link').text).to match(%r{/user/new?rederred_from=XXX})
end

Given 'there is an existing completed user' do
  User.create!(name: 'primary_user', tale: 'Once upon a time')
end

Given 'there is an existing story' do
  user_1 = User.create!(name: 'user_1', tale: 'Part 1')
  user_2 = User.create!(name: 'user_2', tale: 'Part 2')
  User.create!(name: 'user_3', tale: 'Part 3')
  user_2.add_parent user_1
  user_3.add_parent user_2
end

When 'I visit the new user page with the existing user uuid' do
  user = User.all.first
  visit "/user/new?referred_from=#{user.user_uuid}"
end

When 'I visit a user in the middle of the chain' do
  user = User.find_by(name: 'user_2')
  visit "/user/#{user.user_uuid}"
end

Then 'I should see the new user page' do
  expect(find('#referred-from').text).to match(/primary_user/)
  expect(find('#story-so-far').text).to match(/Once upon a time/)
end

When 'I fill in details for the new user' do
  fill_in('user_name', with: 'username')
  select('United Kingdom', from: 'user_country_id')
  fill_in('user_tale', with: 'The End')
  find('input[name="commit"]').click
end

Then 'I see the user show page' do
  user_uuid = User.find_by(name: 'username').user_uuid
  expect(find('#story-so-far').text).to match(/Once upon a time/)
  expect(find('#story-so-far').text).to match(/The End/)
  expect(find('#referral-url')[:href]).to match(%r{/user/new\?referred_from=#{user_uuid}})
end

Then 'I should see the future of the story' do
  expect(find('#story-so-far').text).to match(/Part 1/)
  expect(find('#story-so-far').text).to match(/Part 2/)
  expect(find('#story-evolution').text).to match(/Part 3/)
end

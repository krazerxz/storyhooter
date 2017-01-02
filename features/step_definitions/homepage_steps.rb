Given "there are some users in the database" do
  user_1 = User.create(tale: "beginning")
  user_2 = User.create(tale: "middle")
  user_3 = User.create(tale: "end")

  user_1.add_child user_2
  user_2.add_child user_3

  user_2.add_parent user_1
  user_3.add_parent user_2
end

When "I visit the homepage" do
  visit "/"
end

Then "I should see the homepage" do
  # Example Story
  expect(find("#story-window").text).to match(/middle/)
  expect(find("#story-window").text).to match(/end/)
end

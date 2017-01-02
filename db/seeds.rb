if User.count.zero?
  User.create country: "UK", email: "example@example.com", name: "example", tale: "example_tale", parent: nil, children: [], user_uuid: 1
end

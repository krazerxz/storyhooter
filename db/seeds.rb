if User.count.zero?
  User.create country: "UK", email: "example@example.com", name: "example", tale: "example_tale"
end

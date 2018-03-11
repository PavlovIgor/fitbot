AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

["начинающих", "продолжающих", "продвинутых"].each do |item|
  Program.create( name: "Программа для " + item.to_s )
end

Program.all.each do |program|
  (1..10).each do |item|
    Training.create(
      name: "Тренировка №" + item.to_s,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      queue: item,
      program: program
    )
  end
end

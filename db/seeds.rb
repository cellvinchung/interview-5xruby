# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if User.none?
    password = "123456"
    user = User.create(
        name: "示範使用者",
        email: "demo@example.com",
        password: password,
        role: :admin
    )
    Mission.where(user_id: nil).each do |mission|
        mission.update(user: user)
    end
end
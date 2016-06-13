1000.times do |n|
    name = Faker::Name.name
    email = "sample-#{n+1}@sample.com"
    password = "password"
    uid = "sample-#{n+1}"
    user = User.new(name:  name,
                        email: email,
                        password: password,
                        password_confirmation: password,
                        uid: uid
                        )
    user.skip_confirmation!
    user.save
    if user.persisted?
    user.blogs.create(title: "#{n+1}", content: "sample-#{n+1}")
    end
end
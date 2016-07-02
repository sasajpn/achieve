20.times do |n|
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
    blog = user.blogs.build(title: "#{n+1}", content: "sample-#{n+1}")
    if blog.user_id.present?
        blog.save
    end
end

# even = User.find_by_email("sample-1@sample.com")
# odd = User.find_by_email("sample-2@sample.com")
# Task.create(title: "Task 0",
#             content: "TC0",
#             done: true,
#             user: even,
#             charge: even)
# 1.upto(100) do |n|
#     Task.create(title: "Task #{n}",
#                 content: "TC#{n}",
#                 done: false,
#                 user: n.even? ? even : odd,
#                 charge: n.even? ? even : odd)
# end                
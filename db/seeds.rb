# These users will have super admin powers
users = [%w[Admin admin], %w[King601 king601], %w[Kaptoye kaptoye]]

users.each do |username, email|
  User.create(
    username: username,
    email: "#{email}@athensmc.com",
    password: "password",
    password_confirmation: "password",
    admin: true
  )

  puts "Creating #{username}."
end

{
  "General" => "#4ea1d3",
  # blue
  "Modded Minecraft" => "#ff7473",
  # red
  "Snapshot/Vanilla Minecraft" => "#58C9B9",
  # teal / green
  "Site Feedback" => "#F29B34"
}.each do |name, color|
  ForumCategory.where(name: name, color: color).first_or_create
end

10.times.each do
  user =
    User.create(
      username: Faker::Internet.user_name,
      email: Faker::Internet.email,
      password: "password",
      password_confirmation: "password",
      admin: false
    )

  forum_thread =
    ForumThread.create(
      subject: Faker::HowIMetYourMother.quote,
      user_id: user.id,
      forum_category_id: ForumCategory.all.sample.id
    )

  ForumPost.create(
    user: user,
    body: Faker::Lorem.paragraph(2, false, 4),
    forum_thread: forum_thread
  )

  puts "Created Forum Thread: #{forum_thread.subject}"

  rand(2..15).times.each do
    forum_post =
      ForumPost.create(
        forum_thread_id: forum_thread.id,
        user_id: User.all.sample.id,
        body: Faker::Lorem.paragraph(2, false, 4)
      )

    puts "  Created Post by #{forum_post.user.username}"
  end
end

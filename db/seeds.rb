# Clear existing data
[Patient, User].each(&:destroy_all)

# Create users
receptionist = User.create!(
  email: 'receptionist@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: :receptionist
)

doctor = User.create!(
  email: 'doctor@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: :doctor
)

# Create patients
10.times do |i|
  Patient.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    dob: Faker::Date.birthday(min_age: 18, max_age: 90),
    gender: ['Male', 'Female'].sample,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.full_address,
    created_at: rand(30).days.ago
  )
end

puts "Seeded #{User.count} users and #{Patient.count} patients"
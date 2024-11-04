# spec/factories/candidates.rb
FactoryBot.define do
  factory :candidate do
    name { "Aaron Venema" }
    email { "aaron1venema@gmail.com" }
    skills { ["Ruby", "RSpec"] }
  end
end
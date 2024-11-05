require_relative 'lib/candidate'

candidate = Candidate.new(
  name: 'Aaron Venema',
  email: 'aaron1venema@gmail.com',
  skills: ['Ruby', 'RSpec']
)

candidate.interview_dates << '2024-11-05'
candidate.rate_skill 'Ruby', 5
candidate.rate_skill 'RSpec', 5

puts candidate.to_s

require_relative '../candidate'
require 'factory_bot'
require 'spec_helper.rb'

RSpec.describe Candidate do
  let(:candidate) { build :candidate, name: 'aed', email: 'ewfw' } # Using FactoryBot to build the candidate

  describe '#initialize' do
    subject { candidate.save }

    it { is_expected.to be_truthy }
  end

  # describe '#email' do
  #   subject { candidate.email }

  #   it 'allows reading the email' do
  #     is_expected.to eq 'aaron1venema@gmail.com'
  #   end

  #   context 'updates the email' do
  #     before { candidate.email = 'avenema@thepestogroup.com' }

  #     it 'is the new email' do
  #       is_expected.to eq 'avenema@thepestogroup.com'
  #     end
  #   end
  # end

  # describe '#name' do
  #   subject { candidate.name }

  #   it 'allows reading the name' do
  #     is_expected.to eq 'Aaron Venema'
  #   end

  #   it 'does not allow updating the name' do
  #     expect { candidate.name = 'Mr. Venema' }.to raise_error NoMethodError
  #   end
  # end

  # describe '#skills' do
  #   subject { candidate.skills }

  #   it 'allows reading the skills' do
  #     is_expected.to eq ['Ruby', 'RSpec']
  #   end

  #   context 'updates the skills' do
  #     before { candidate.skills = ['Python'] }

  #     it 'is the new skills' do
  #       is_expected.to eq ['Python']
  #     end
  #   end
  # end

  # describe '#add_skills' do
  #   let!(:initial_skill_count) { candidate.skills.size }

  #   subject { candidate.skills }

  #   before { candidate.add_skills 'JavaScript', 'React' }

  #   it 'adds exactly two new skills' do
  #     expect(subject.size).to eq initial_skill_count + 2
  #   end

  #   it 'includes the new skills' do
  #     is_expected.to include 'JavaScript', 'React'
  #   end
  # end
end

require_relative '../candidate'

RSpec.describe Candidate do
  let(:skills) { ['Ruby', 'RSpec'] }
  let(:candidate) do
    described_class.
      new name: 'Aaron Venema', 
          email: 'aaron1venema@gmail.com',
          skills:
  end

  describe '#initialize' do
    subject { candidate }

    it { is_expected.to be_truthy }
  end

  describe '#email' do
    subject { candidate.email }

    it 'allows reading the email' do
      is_expected.to eq 'aaron1venema@gmail.com'
    end

    context 'updates the email' do
      before { candidate.email = 'avenema@thepestogroup.com' }

      it 'is the new email' do
        is_expected.to eq 'avenema@thepestogroup.com'
      end
    end
  end

  describe '#name' do
    subject { candidate.name }

    it 'allows reading the name' do
      is_expected.to eq 'Aaron Venema'
    end

    it 'does not allow updating the name' do
      expect { candidate.name = 'Mr. Venema' }.to raise_error NoMethodError
    end
  end

  describe '#skills' do
    subject { candidate.skills }

    it 'allows reading the skills' do
      is_expected.to eq ['Ruby', 'RSpec']
    end

    context 'updates the skills' do
      before { candidate.skills = ['Python'] }

      it 'is the new skills' do
        is_expected.to eq ['Python']
      end
    end
  end

  describe '#to_s' do
    context 'candidate has no skills or interview dates' do
      let(:skills) { }
      let(:expected_output) do
        "Name: Aaron Venema\nEmail: aaron1venema@gmail.com\nSkills: "
      end

      it 'is a string with name and email' do
        expect(candidate.to_s).to eq expected_output
      end
    end

    context 'candidate has skills' do
      let(:expected_output) do
        "Name: Aaron Venema\nEmail: aaron1venema@gmail.com\nSkills: Ruby, RSpec"
      end

      it 'is a string with name, email and skills' do
        expect(candidate.to_s).to eq expected_output
      end
    end

    context 'candidate has skills and skill levels' do
      let(:expected_output) do
        "Name: Aaron Venema\nEmail: aaron1venema@gmail.com\nSkills: Ruby, RSpec\nSkill Levels: Ruby: 4, RSpec: 5"
      end

      before do
        candidate.rate_skill('Ruby', 4)
        candidate.rate_skill('RSpec', 5)
      end

      it 'includes skill levels in the output' do
        expect(candidate.to_s).to eq expected_output
      end
    end

    context 'candidate has interview dates' do
      let(:expected_output) do
        "Name: Aaron Venema\nEmail: aaron1venema@gmail.com\nSkills: Ruby, RSpec\nInterview Dates: 2024-11-05"
      end

      before do
        candidate.interview_dates << '2024-11-05'
      end

      it 'includes interview dates in the output' do
        expect(candidate.to_s).to eq expected_output
      end
    end

    context 'candidate has skills, skill levels, and interview dates' do
      let(:expected_output) do
        "Name: Aaron Venema\nEmail: aaron1venema@gmail.com\nSkills: Ruby, RSpec\nSkill Levels: Ruby: 4, RSpec: 5\nInterview Dates: 2024-11-05"
      end

      before do
        candidate.rate_skill('Ruby', 4)
        candidate.rate_skill('RSpec', 5)
        candidate.interview_dates << '2024-11-05'
      end

      it 'includes all information in the output' do
        expect(candidate.to_s).to eq(expected_output)
      end
    end
  end

  describe '#add_skills' do
    let!(:initial_skill_count) { candidate.skills.size }

    subject { candidate.skills }

    before { candidate.add_skills 'JavaScript', 'React' }

    it 'adds exactly two new skills' do
      expect(subject.size).to eq initial_skill_count + 2
    end

    it 'includes the new skills' do
      is_expected.to include 'JavaScript', 'React'
    end
  end

  describe '#rate_skill' do
    let(:skill) { 'Ruby' }
    let(:rating) { 5 }

    subject { candidate.rate_skill(skill, rating) }

    context 'skill exists' do
      it 'sets the skill level' do
        subject
        expect(candidate.skill_levels).to include 'Ruby' => 5
      end
    end

    context 'skill does not exist' do
      let(:skill) { 'Django' }

      it 'raises an ArgumentError' do
        expect { subject }.
          to raise_error ArgumentError,
                        "Django is not part of the candidate's skills."
      end
    end

    context 'skill level is less than 1' do
      let(:rating) { 0 }

      it 'raises an ArgumentError' do
        expect { subject }.
          to raise_error ArgumentError,
                        'Skill level must be between 1 and 5.'
      end
    end

    context 'skill level is greater than 5' do
      let(:rating) { 6 }

      it 'raises an ArgumentError' do
        expect { subject }.
          to raise_error ArgumentError,
                        'Skill level must be between 1 and 5.'
      end
    end
  end

  describe '#clear_skill_rating' do
    subject { candidate.clear_skill_rating(skill) }

    context 'skill rating exists' do
      let(:skill) { 'Ruby' }

      before do
        candidate.skill_levels[skill] = 4
      end

      it 'removes the skill rating' do
        subject
        expect(candidate.skill_levels).not_to have_key 'Ruby'
      end
    end

    context 'skill rating does not exist' do
      let(:skill) { 'NonexistentSkill' } 

      it 'does not raise an error' do
        expect { subject }.not_to raise_error
      end
    end
  end

  describe '#has_interviews_scheduled?' do
    subject { candidate.has_interviews_scheduled? }

    context 'no interviews dates' do
      it { is_expected.to be_falsey }
    end

    context 'one interview date' do
      before do
        candidate.interview_dates << '2024-11-15'
      end

      it { is_expected.to be_truthy }
    end

    context 'multiple interview dates' do
      before do
        candidate.interview_dates << '2024-11-15'
        candidate.interview_dates << '2024-11-20'
      end

      it { is_expected.to be_truthy }
    end
  end
end

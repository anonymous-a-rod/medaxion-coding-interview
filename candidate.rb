class Candidate
  attr_reader :name
  attr_accessor :email, :skills, :interview_dates, :skill_levels

  def initialize(name, email, skills = [])
    @name = name
    @email = email
    @skills = skills
    @interview_dates = []
    @skill_levels = {}
  end

  def to_s
    info = "Name: #{@name}\nEmail: #{@email}\nSkills: #{@skills.join(', ')}"
    info += "\nSkill Levels: #{format_skill_levels}" unless @skill_levels.empty?
    info += "\nInterview Dates: #{format_interview_dates}" unless @interview_dates.empty?
    info
  end

  def add_skills(*args)
    args.each { |skill| @skills << skill }
  end

  def rate_skill(skill, level)
    unless @skills.include?(skill)
      raise ArgumentError, "#{skill} is not part of the candidate's skills."
    end
    unless (1..5).include?(level)
      raise ArgumentError, "Skill level must be between 1 and 5."
    end

    @skill_levels[skill] = level
  end

  def clear_skill_rating(skill)
    @skill_levels.delete(skill)
  end

  def has_interviews_scheduled?
    !@interview_dates.empty?
  end

  private

  def format_skill_levels
    @skill_levels.map { |skill, level| "#{skill}: #{level}" }.join(', ')
  end

  def format_interview_dates
    @interview_dates.join(', ')
  end
end

require 'rspec/autorun'

class Entity
  POSSIBLE_EARTH_LANGUAGES = ['French', 'English', 'Spanish', 'Russian']
  POSSIBLE_NON_EARTH_LANGUAGES = ['Camensko', 'Barenden', 'Chamilia', 'Chohoron']
  attr_accessor :interstellar_traveler, :location, :native_language

  def initialize(travels,current_location,language)
    @interstellar_traveler = travels
    @location = current_location
    @native_language = language
  end

  def am_i_an_alien_to_earth?(entity)
    from_other_world = false
    if entity.location == 'Earth' && entity.interstellar_traveler? == false
        from_other_world = false
    elsif (entity.location != 'Earth' && entity.interstellar_traveler? == false)
        from_other_world = true
    elsif entity.interstellar_traveler? == true
     native_language_non_earth = true
      Entity::POSSIBLE_EARTH_LANGUAGES.each do |x|
          if entity.native_language == x
            native_language_non_earth = false
          end
      end
      from_other_world = true if native_language_non_earth == true
    end
    return from_other_world
  end

  def interstellar_traveler?
    if @interstellar_traveler
      return true
    else
      return false
    end
  end
end

describe Entity do
  describe 'when it travels, is on Earth, and speaks Camensko' do
    let(:entity) { Entity.new(true,'Earth','Camensko') }
    
    it 'should be an alien' do
      expect(entity.am_i_an_alien_to_earth?(entity)).to be_truthy
    end
  end

  describe 'when it travels, is on Earth, and speaks French' do
    let(:entity) { Entity.new(true,'Earth','French') }
    
    it 'should not be an alien' do
      expect(entity.am_i_an_alien_to_earth?(entity)).not_to eq(true)
    end
  end

  describe 'when it does not travel, is on Earth, and speaks French' do
    let(:entity) { Entity.new(false,'Earth','French') }

    it 'should not be an alien' do
      expect(entity.am_i_an_alien_to_earth?(entity)).to eq(false)
    end
  end
end

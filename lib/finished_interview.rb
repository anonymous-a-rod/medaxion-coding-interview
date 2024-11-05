require 'rspec/autorun'

class Entity
  EARTH_LANGUAGES = ['French', 'English', 'Spanish', 'Russian']

  def initialize(interstellar_traveler, location, native_language)
    @interstellar_traveler = interstellar_traveler
    @location = location
    @native_language = native_language
  end

  def from_earth?
    return !EARTH_LANGUAGES.include?(native_language) if interstellar_traveler?
    !is_earth?
  end

  alias am_i_an_alien_to_earth? from_earth?

  private

  attr_reader :interstellar_traveler, :location, :native_language

  def interstellar_traveler?
    interstellar_traveler
  end

  def is_earth?
    location == 'Earth'
  end
end

describe Entity do
  let(:entity) { Entity.new interstellar_traveler, location, native_language }

  context 'am_i_an_alien_to_earth?' do
    let(:interstellar_traveler) { true }
    let(:location) { 'Earth' }
    let(:native_language) { 'Camensko' }

    subject { entity.am_i_an_alien_to_earth? }

    it { is_expected.to be_truthy }
  end

  context 'from_earth?' do
    subject { entity.from_earth? }

    context 'when it travels' do
      let(:interstellar_traveler) { true }

      context 'is on Earth' do
        let(:location) { 'Earth' }

        describe 'speaks Camensko' do
          let(:native_language) { 'Camensko' }

          it 'should be an alien' do
            is_expected.to be true
          end
        end

        describe 'speaks French' do
          let(:native_language) { 'French' }

          it 'should not be an alien' do
            is_expected.not_to be true
          end
        end
      end
    end

    describe 'when it does not travel, is on Earth, and speaks French' do
      let(:interstellar_traveler) { false }
      let(:location) { 'Earth' }
      let(:native_language) { 'French' }

      it 'should not be an alien' do
        is_expected.to be false
      end
    end
  end
end

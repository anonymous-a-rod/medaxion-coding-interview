require 'rspec/autorun'

class Entity
  EARTH_LANGUAGES = ['French', 'English', 'Spanish', 'Russian']

  def initialize(travels, location, language)
    @travels = travels
    @location = location
    @language = language
  end

  def not_from_earth?
    return !is_earth_language? if travels
    !is_earth?
  end

  alias am_i_an_alien_to_earth? not_from_earth?

  private

  attr_reader :travels, :location, :language

  def is_earth_language?
    EARTH_LANGUAGES.include?(language)
  end

  def is_earth?
    location == 'Earth'
  end
end

describe Entity do
  let(:entity) { Entity.new travels, location, language }

  describe '#am_i_an_alien_to_earth?' do
    let(:travels) { true }
    let(:location) { 'Earth' }
    let(:language) { 'Camensko' }

    subject { entity.am_i_an_alien_to_earth? }

    it { is_expected.to be_truthy }
  end

  describe '#not_from_earth?' do
    subject { entity.not_from_earth? }

    context 'interstellar travels' do
      let(:travels) { true }

      context 'on Earth' do
        let(:location) { 'Earth' }

        context 'speaks Camensko' do
          let(:language) { 'Camensko' }

          it 'should be an alien' do
            is_expected.to be true
          end
        end

        context 'speaks French' do
          let(:language) { 'French' }

          it 'should not be an alien' do
            is_expected.to be false
          end
        end
      end
    end

    context 'not an interstellar travels' do
      let(:travels) { false }

      context 'not on Earth' do
        let(:location) { 'Earth' }

          context 'speaks French' do
          let(:language) { 'French' }
    
          it 'should not be an alien' do
            is_expected.to be false
          end
        end
      end
    end

  end
end

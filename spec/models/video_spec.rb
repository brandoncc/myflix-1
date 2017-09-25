require 'spec_helper'

RSpec.describe Video, :type => :model do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe 'search_by_title' do
    it 'returns an empty array if there is no match' do
      futurama = Video.create(title: 'Futurama', description: 'cool')
      back_to_future = Video.create(title: 'Back to Future', description: 'cool')

      expect(Video.search_by_title('hello')).to eq([])
    end

    it 'returns an array of one video for an exact match' do
      futurama_s1 = Video.create(title: 'Futurama Season 1', description: 'cool')
      back_to_future = Video.create(title: 'Back to Future', description: 'cool')

      expect(Video.search_by_title('Futurama Season 1')).to eq([futurama_s1])
    end

    it 'returns an array of one video for a partial match' do
      futurama_s1 = Video.create(title: 'Futurama Season 1', description: 'cool')
      back_to_future = Video.create(title: 'Back to Future', description: 'cool')

      expect(Video.search_by_title('Futurama')).to eq([futurama_s1])
    end
    it 'returns an array of matched videos ordered by created_at' do
      futurama_s1 = Video.create(title: 'Futurama Season 1', description: 'cool', created_at: 2.day.ago)
      futurama = Video.create(title: 'Futurama', description: 'cool', created_at: 1.day.ago)
      back_to_future = Video.create(title: 'Back to Future', description: 'cool', created_at: 3.day.ago)

      expect(Video.search_by_title('Futur')).to eq([futurama, futurama_s1, back_to_future])
    end

    it 'returns an empty array if title is empty string' do
      futurama = Video.create(title: 'Futurama', description: 'cool', created_at: 1.day.ago)
      back_to_future = Video.create(title: 'Back to Future', description: 'cool', created_at: 3.day.ago)

      expect(Video.search_by_title('')).to eq([])
    end
  end
end
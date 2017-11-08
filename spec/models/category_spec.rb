require 'spec_helper'

describe Category, :type => :model do
  it { should have_many(:videos) }

  describe 'recent_videos' do
    it 'returns videos ordered from the most recent to less recent ones' do
      comedies = Category.create(name: 'comedies')
      monk = Video.create(title: 'Monk', description: 'cool', created_at: 1.day.ago, category: comedies)
      futurama = Video.create(title: 'Futurama', description: 'cool', created_at: 3.day.ago, category: comedies)
      south_park = Video.create(title: 'South Park', description: 'cool', created_at: 2.day.ago, category: comedies)

      expect(comedies.recent_videos).to eq([monk, south_park, futurama])
    end

    it 'returns all videos if it contains less than 6 ones' do
      comedies = Category.create(name: 'comedies')
      monk = Video.create(title: 'Monk', description: 'cool', created_at: 1.day.ago, category: comedies)
      futurama = Video.create(title: 'Futurama', description: 'cool', created_at: 3.day.ago, category: comedies)
      south_park = Video.create(title: 'South Park', description: 'cool', created_at: 2.day.ago, category: comedies)

      expect(comedies.recent_videos.size).to eq(3)
    end

    it 'returns 6 videos if it contains more than 6 ones' do
      comedies = Category.create(name: 'comedies')
      7.times do
        Video.create(title: 'Monk', description: 'cool', created_at: 1.day.ago, category: comedies)
      end

      expect(comedies.recent_videos.size).to eq(6)
    end
  end
end
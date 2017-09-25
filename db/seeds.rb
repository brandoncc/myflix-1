# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Video.create(title: 'South Park', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: 'http://dummyimage.com/166x236/a1b2c3/d4e5f6', large_cover_url: 'http://dummyimage.com/665x375/000000/00a2ff')
# Video.create(title: 'Big Bang Theory', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: 'http://dummyimage.com/166x236/112233/ddeeff', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff')
# Video.create(title: 'Monk', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: 'http://dummyimage.com/166x236/a1b2c3/d4e5f6', large_cover_url: '/tmp/monk_large.jpg')

# Category.create(name: 'TV Commedies')
# Category.create(name: 'TV Dramas')
# Category.create(name: 'Reality TV')

Video.create(title: 'Monk', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg', category_id: 6)
Video.create(title: 'Big Bang Theory', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: 'http://dummyimage.com/166x236/112233/ddeeff', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff', category_id: 6)
Video.create(title: 'Family guy', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: '/tmp/family_guy.jpg', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff', category_id: 6)
Video.create(title: 'Futurama', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: '/tmp/futurama.jpg', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff', category_id: 6)
Video.create(title: 'South Park', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: 'http://dummyimage.com/166x236/a1b2c3/d4e5f6', large_cover_url: 'http://dummyimage.com/665x375/000000/00a2ff', category_id: 6)
Video.create(title: 'South Park', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: '/tmp/south_park.jpg', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff', category_id: 6)

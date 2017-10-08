# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


commedies = Category.create(name: 'TV Commedies')
dramas = Category.create(name: 'TV Dramas')
reality = Category.create(name: 'Reality TV')

Video.create(title: 'Monk', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg', category: commedies)
Video.create(title: 'Big Bang Theory', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: 'http://dummyimage.com/166x236/112233/ddeeff', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff', category: commedies)
Video.create(title: 'Family guy', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: '/tmp/family_guy.jpg', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff', category: commedies)
Video.create(title: 'Futurama', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: '/tmp/futurama.jpg', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff', category: commedies)
south_park = Video.create(title: 'South Park', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: 'http://dummyimage.com/166x236/a1b2c3/d4e5f6', large_cover_url: 'http://dummyimage.com/665x375/000000/00a2ff', category: commedies)
Video.create(title: 'South Park', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: '/tmp/south_park.jpg', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff', category: commedies)
Video.create(title: 'Big Bang Theory', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: 'http://dummyimage.com/166x236/112233/ddeeff', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff', category: commedies)
Video.create(title: 'Family guy', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: '/tmp/family_guy.jpg', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff', category: reality)
Video.create(title: 'Futurama', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: '/tmp/futurama.jpg', large_cover_url: 'http://dummyimage.com/665x375/ffb300/00a2ff', category: reality)
Video.create(title: 'South Park', description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: 'http://dummyimage.com/166x236/a1b2c3/d4e5f6', large_cover_url: 'http://dummyimage.com/665x375/000000/00a2ff', category: reality)

walter = User.create(email: 'walter@gmail.com', password: 'password', full_name: "walter wang")

Review.create(user: walter, video: south_park, rating: 5, content: 'Best show ever')
Review.create(user: walter, video: south_park, rating: 4, content: 'Most important show')
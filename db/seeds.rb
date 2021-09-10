puts 'generating intelligent life...'
broker = User.create(
  email: 'admin@mail.com',
  name: 'John Doe',
  password: 'password'
)

puts 'creating views...'
about_us_view = View.create(name: 'about_us', variant: 1)
about_self_care_view = View.create(name: 'about_self_care', variant: 1)
information_view = View.create(name: 'information', variant: 1)
services_view = View.create(name: 'services', variant: 0)

puts 'creating image...'
# image = Image.create(
#   url: 'https://assets.zyto.com/wp-content/uploads/2018/05/holistic-health-concept-woman-doing-yoga-on-beach-at-dusk.jpg',
#   alt_text: 'Alt attribute'
# )
image_file = URI.open('https://assets.zyto.com/wp-content/uploads/2018/05/holistic-health-concept-woman-doing-yoga-on-beach-at-dusk.jpg')
image = Image.create(alt_text: 'Alt attribute')
image.file.attach(io: image_file, filename: 'article_image.jpg', content_type: 'image/jpg')

puts 'creating sections...'
section_regular = Section.create(
  view_id: information_view.id,
  header: 'Section regular',
  description: 'A Solid App is composed of functions that we call Components. Component names in Solid follow the Pascal naming convention in which the first letter of each word in a component name is capitalized. This name can then be used as tags within our JSX like',
  variant: 0,
  image: image
)
section_no_image = Section.create(
  view_id: about_self_care_view.id,
  header: 'Section no Image',
  description: 'A Solid App is composed of functions that we call Components. Component names in Solid follow the Pascal naming convention in which the first letter of each word in a component name is capitalized. This name can then be used as tags within our JSX like',
  variant: 1
)
section_carousel = Section.create(
  view_id: about_us_view.id,
  header: 'Section Carousel',
  variant: 2
)
puts 'creating buttons...'
buttons = Cta.create(
  text: 'button',
  link: 'https://github.com/AgileVentures/kcsc_api',
  section_id: section_regular.id
)

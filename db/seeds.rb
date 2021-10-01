puts 'clears old data...'
[Image, Section, Cta, View].each do | model |
  model.destroy_all
end

puts 'generating intelligent life...'
broker = User.create(
  email: 'admin@mail.com',
  name: 'John Doe',
  password: 'password'
)

# ---------- CREATING SECTONS FOR ABOUT US VIEW -----------
puts 'creating sections for about_us view'
background_and_setup = Section.create(
  header: 'Background and Set-up',
  description: 'This section tells vistor about Community Health West London background and setup',
  variant: 0,
)

plans = Section.create(
  header: 'Plans',
  description: 'This section tells vistor Community Health West London plans to improve lives of people',
  variant: 1
)

work_with_us_btn = Cta.create(
  text: 'Contact us',
  link: '/contact'
)
work_with_us = Section.create(
  header: 'Work with us',
  description: 'This section tells vistor how beneficial it is to work with Community Health West London',
  variant: 0,
  buttons: [work_with_us_btn]
)

our_partners = Section.create(
  header: 'Our Partners',
  cards: [],
  variant: 2
)

vcs_info_btn_1 = Cta.create(
  text: 'KCSC Contact',
  link: 'https://www.kcsc.org.uk/contact-us'
)
vcs_info_btn_2 = Cta.create(
  text: 'KCSC Website',
  link: 'https://www.kcsc.org.uk'
)
vcs_info = Section.create(
  header: 'VCS info',
  description: 'This section tells vistor about VCS',
  variant: 0,
  buttons: [vcs_info_btn_1, vcs_info_btn_2]
)

about_us_sections = [background_and_setup, plans, work_with_us, our_partners, vcs_info]

# ---------- CREATING SECTONS FOR ABOUT SELF CARE VIEW -----------
puts 'creating sections for about_self_care view'

self_care = Section.create(
  header: 'Self Care',
  description: 'This section tells vistor what is Self Care and how beneficial it is for them',
  variant: 0,
)

social_prescribing = Section.create(
  header: 'Social Prescribing',
  description: 'This section tells vistor what is Social Prescribing and how beneficial it is for them',
  variant: 0,
)

case_studies_kcsc = Section.create(
  header: 'Case studies from KCSC',
  description: 'This section spells out about results of case studies from KCSC',
  variant: 1
)

case_studies_other = Section.create(
  header: 'Case studies from other organisations',
  description: 'This section spells out about results of case studies from other organisations',
  variant: 1
)

about_self_care_sections = [self_care, social_prescribing, case_studies_kcsc, case_studies_other]

# ---------- CREATING SECTONS FOR INFORMATION VIEW -----------
puts 'creating sections for information view'

information = Section.create(
  header: 'Information',
  description: 'On this page, you can find very usefull information about Self Care and Healthcare in West London',
  variant: 0,
)

information_sections = [information]

# ---------- CREATING SECTONS FOR SERVICES VIEW -----------
puts 'creating sections for services view'

find_self_care_service_btn = Cta.create(
  text: 'Find self-care service',
  link: '/services/search'
)
find_self_care_service = Section.create(
  header: 'Find a Self-Care service',
  description: 'Find local health and wellbeing services in the West London community.',
  variant: 0,
  buttons: [find_self_care_service_btn]
)

long_term_self_care_btn = Cta.create(
  text: 'my care my way',
  link: 'http://mycaremyway.co.uk/'
)
long_term_self_care = Section.create(
  header: 'Long term Self Care',
  description: 'Need support with your long term health conditions & are registered for a GP surgery in West London? You can access My Care My Way through speaking to your GP.',
  variant: 0,
  buttons: [long_term_self_care_btn]
)

mental_health_btn = Cta.create(
  text: 'Take me there',
  link: ''
)
mental_health = Section.create(
  header: 'Mental health',
  description: 'A referral to a service in the community to support peoples mental health.',
  variant: 0,
  buttons: [mental_health_btn]
)

n_kensington_self_care_btn = Cta.create(
  text: 'Take me there',
  link: ''
)
n_kensington_self_care = Section.create(
  header: 'North Kensington Self-Care',
  description: 'A referral to services in the community to support people in North Kensington affected by the Grenfell Tower fire.',
  variant: 0,
  buttons: [n_kensington_self_care_btn]
)

find_a_link_workers_btn = Cta.create(
  text: 'Take me there',
  link: ''
)
find_a_link_workers = Section.create(
  header: 'Find a Link workers',
  description: 'A Social Prescribing Link worker is someone based in a GP surgery that will link people up to services in their local community.',
  variant: 0,
  buttons: [find_a_link_workers_btn]
)

services_sections = [find_self_care_service, long_term_self_care, mental_health, n_kensington_self_care,
                     find_a_link_workers]

puts 'creating views...'
about_us_view = View.create(name: 'about_us', variant: 1, sections: about_us_sections)
about_self_care_view = View.create(name: 'about_self_care', variant: 2, sections: about_self_care_sections)
information_view = View.create(name: 'information', variant: 3, sections: information_sections)
services_view = View.create(name: 'services', variant: 0, sections: services_sections)

puts 'attaching images...'
sections = Section.all
sections.each do |section|
  image = Image.create(section: section)
  file = File.open(Rails.root.join('spec', 'fixtures', 'files', 'placeholder.jpeg'))
  image.file.attach(io: file, filename: 'placeholder.jpeg', content_type: 'image/jpg')
end

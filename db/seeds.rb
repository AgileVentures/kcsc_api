puts 'generating intelligent life...'
broker = User.create(
  email: "admin@mail.com", 
  name: "John Doe", 
  password: "password"
)

sections = [
  {
    id: 1,
    variant: "regular",
    header: "Self Care",
    description: "This section tells vistor what is Self Care and how beneficial it is for them",
    image: {
      url: "https://assets.zyto.com/wp-content/uploads/2018/05/holistic-health-concept-woman-doing-yoga-on-beach-at-dusk.jpg",
      alt: "Woman is standing on the ocean beach in the sunset"
    },
    buttons: []
  },
  {
    id: 2,
    variant: "regular",
    header: "Social Prescribing",
    description: "This section tells vistor what is Social Prescribing and how beneficial it is for them",
    image: {
      url: "https://www1.racgp.org.au/getattachment/12340621-1a55-415a-8417-a3486b08af95/attachment.aspx",
      alt: "People doing stuff I cannot really explain"
    },
    buttons: []
  },
  {
    id: 3,
    variant: "no_image",
    header: "Case studies from KCSC",
    description: "This section spells out about results of case studies from KCSC"
  },
  {
    id: 4,
    variant: "no_image",
    header: "Case studies from other organisations",
    description: "This section spells out about results of case studies from other organisations"
  },
  {
    id: 5,
    variant: "regular",
    header: "Background and Set-up",
    description: "This section tells vistor about Community Health West London background and setup",
    image: {
      url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqLT-VZvroTicDcz7wqtwKrUy75Lb9-v9LzQ&usqp=CAU",
      alt: "People walk across the field holding each other"
    },
    buttons: []
  },
  {
    id: 6,
    variant: "no_image",
    header: "Plans",
    description: "This section tells vistor Community Health West London plans to improve lives of people"
  },
  {
    id: 7,
    variant: "regular",
    header: "Work with us",
    description: "This section tells vistor how beneficial it is to work with Community Health West London",
    image: {
      url: "https://www.incimages.com/uploaded_files/image/1920x1080/getty_666823506_385332.jpg",
      alt: "Buisness man and woman are about to shake hands"
    },
    buttons: [
      {
        id: 1,
        text: "Contact us",
        link: "/contact"
      }
    ]
  },
  {
    id: 8,
    variant: "carousel",
    header: "Our Partners",
    cards: [
      {
        id: 1,
        publish: true,
        logo: "https://www.kcsc.org.uk/sites/kcsc.org.uk/themes/bootstrap_kcsc_2019/logo.png",
        alt: "logo of Kensington & Chelsea Social Council organization",
        organization: "Kensington & Chelsea Social Council",
        description: "Description of what this partner does",
        links: {
          web: "https://www.kcsc.org.uk/",
          facebook: "https://www.facebook.com/smartchelsea",
          twitter: "https://twitter.com/smartlondon"
        }
      },
      {
        id: 2,
        publish: true,
        logo: "https://scontent-arn2-2.xx.fbcdn.net/v/t31.18172-8/1119949_644130218939075_1717776792_o.jpg?_nc_cat=108&ccb=1-3&_nc_sid=6e5ad9&_nc_ohc=xV2RGd7fgnsAX-pFmUi&_nc_ht=scontent-arn2-2.xx&oh=f2a844537acc3a1ea5d5ee74efc8f5df&oe=6125A1A2",
        alt: "logo of SMART organization",
        organization: "SMART",
        description: "Description of what this partner does",
        links: {
          web: "https://www.smartlondon.org.uk/",
          facebook: "https://www.facebook.com/KCSocialCouncil/",
          twitter: "https://twitter.com/kcsocialcouncil"
        }
      },
      {
        id: 3,
        publish: true,
        logo: "https://www.openage.org.uk/sites/openage.org.uk/themes/openage/images/layout/logo.png",
        alt: "logo of Open Age organization",
        organization: "Open Age",
        description: "Description of what this partner does",
        links: {
          web: "https://www.openage.org.uk/",
          facebook: "",
          twitter: "https://twitter.com/open_age"
        }
      },
      {
        id: 4,
        publish: true,
        logo: "https://www.onewestminster.org.uk/themes/custom/ow_theme/images/logo.jpg",
        alt: "logo of One Westminster organization",
        organization: "One Westminster",
        description: "Description of what this partner does",
        links: {
          web: "https://www.onewestminster.org.uk/",
          facebook: "",
          twitter: "https://twitter.com/One_Westminster"
        }
      }
    ]
  },
  {
    id: 9,
    variant: "regular",
    header: "VCS info",
    description: "This section tells vistor about VCS",
    image: {
      url: "https://images.squarespace-cdn.com/content/v1/5aa96c579772aea9adaa2ef7/1608213927182-U8CQ7HICVAFDYKJZ7W8A/HealthySelfCareIdeas_1220.jpg",
      alt: "Picture of happy woman"
    },
    buttons: [
      {
        id: 2,
        text: "KCSC Contact",
        link: "https://www.kcsc.org.uk/contact-us"
      },
      {
        id: 3,
        text: "KCSC Website",
        link: "https://www.kcsc.org.uk"
      }
    ]
  },
  {
    id: 10,
    variant: "regular",
    header: "Information",
    description: "On this page, you can find very usefull information about Self Care and Healthcare in West London",
    image: {
      url: "https://media.rbcdn.ru/media/news/shutterstock349400798_ocj7iaS.jpg",
      alt: "Abstract information image"
    },
    buttons: []
  },
  {
    id: 11,
    variant: "regular",
    header: "Find a Self-Care service",
    description: "Find local health and wellbeing services in the West London community.",
    image: {
      url: "https://prikolist.club/wp-content/uploads/2019/07/tancuyuschaya_devushka_2_14144925-1024x717.jpg",
      alt: "Happy girl watering flowers"
    },
    buttons: [{
      id: 4,
      text: "Find self-care service",
      link: "/services/search"
    }]
  },
  {
    id: 12,
    variant: "regular",
    header: "Long term Self Care",
    description: "Need support with your long term health conditions & are registered for a GP surgery in West London? You can access My Care My Way through speaking to your GP.",
    image: {
      url: "https://wellnesscenter.uic.edu/wp-content/uploads/sites/100/2020/07/01-04-1090x595.jpg",
      alt: "Happy girl watering flowers"
    },
    buttons: [
      {
        id: 5,
        text: "my care my way",
        link: "http://mycaremyway.co.uk/"
      }
    ]
  },
  {
    id: 13,
    variant: "regular",
    header: "Mental health",
    description: "A referral to a service in the community to support peoples mental health.",
    image: {
      url: "https://prikolist.club/wp-content/uploads/2019/07/tancuyuschaya_devushka_2_14144925-1024x717.jpg",
      alt: "Happy girl watering flowers"
    },
    buttons: [
      {
        id: 6,
        text: "Take me there",
        link: ""
      }
    ]
  },
  {
    id: 14,
    variant: "regular",
    header: "North Kensington Self-Care",
    description: "A referral to services in the community to support people in North Kensington affected by the Grenfell Tower fire.",
    image: {
      url: "https://wellnesscenter.uic.edu/wp-content/uploads/sites/100/2020/07/01-04-1090x595.jpg",
      alt: "Happy girl watering flowers"
    },
    buttons: [
      {
        id: 7,
        text: "Take me there",
        link: ""
      }
    ]
  },
  {
    id: 15,
    variant: "regular",
    header: "Find a Link workers",
    description: "A Social Prescribing Link worker is someone based in a GP surgery that will link people up to services in their local community.",
    image: {
      url: "https://prikolist.club/wp-content/uploads/2019/07/tancuyuschaya_devushka_2_14144925-1024x717.jpg",
      alt: "Happy girl watering flowers"
    },
    buttons: [
      {
        id: 8,
        text: "Take me there",
        link: ""
      }
    ]
  }
]

class Article::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :teaser, :date, :image

  def teaser
    object.body.truncate(100)
  end

  def date
    object.created_at.strftime('%Y-%m-%d')
  end

  def image
    {
      url: 'https://healthtechmagazine.net/sites/healthtechmagazine.net/files/styles/cdw_hero/public/articles/%5Bcdw_tech_site%3Afield_site_shortname%5D/202007/20200630_HT_Web_MonITor_Tech-Organizations-Should-Consider.jpg?itok=adOWwJ9x',
      alt: 'Nice doctor picture'
    }
  end
end

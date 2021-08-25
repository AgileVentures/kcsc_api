class Article::ShowSerializer < ActiveModel::Serializer
  attributes :id, :id, :title, :body, :date, :image
  belongs_to :author, serializer: Users::Serializer

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

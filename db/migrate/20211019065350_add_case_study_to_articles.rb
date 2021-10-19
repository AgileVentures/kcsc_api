class AddCaseStudyToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :case_study, :boolean, default: false

    Article.update_all(case_study: false)
  end
end

class AddCaseStudyToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :case_study, :boolean
  end
end

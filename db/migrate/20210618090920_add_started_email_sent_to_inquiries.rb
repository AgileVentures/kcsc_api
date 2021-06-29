class AddStartedEmailSentToInquiries < ActiveRecord::Migration[6.1]
  def change
    add_column :inquiries, :started_email_sent, :boolean
  end
end

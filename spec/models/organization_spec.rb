RSpec.describe Organization, type: :model do
  describe 'Database table' do
    it {
      is_expected.to have_db_column(:name)
        .of_type(:string)
    }
    it {
      is_expected.to have_db_column(:description)
        .of_type(:text)
    }
    it {
      is_expected.to have_db_column(:latitude)
        .of_type(:float)
    }
    it {
      is_expected.to have_db_column(:longitude)
        .of_type(:float)
    }
    it {
      is_expected.to have_db_column(:telephone)
        .of_type(:string)
    }
    it {
      is_expected.to have_db_column(:email)
        .of_type(:string)
    }
    it {
      is_expected.to have_db_column(:telephone)
        .of_type(:string)
    }
    it {
      is_expected.to have_db_column(:address)
        .of_type(:string)
    }
    it {
      is_expected.to have_db_column(:postcode)
        .of_type(:string)
    }
    it {
      is_expected.to have_db_column(:website)
        .of_type(:string)
    }
    it {
      is_expected.to have_db_column(:charity_commission_id)
        .of_type(:integer)
    }
    it {
      is_expected.to have_db_column(:imported_id)
        .of_type(:integer)
    }
    it {
      is_expected.to have_db_column(:imported_from)
        .of_type(:string)
    }
    it {
      is_expected.to have_db_column(:publish_address)
        .of_type(:boolean)
    }
    it {
      is_expected.to have_db_column(:publish_telphone)
        .of_type(:boolean)
    }
  end
end

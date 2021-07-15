require 'rails_helper'

RSpec.describe Item do
  describe 'relationships/validations' do
    it { should belong_to(:merchant) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end
end

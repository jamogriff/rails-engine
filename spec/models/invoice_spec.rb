require 'rails_helper'

RSpec.describe Invoice do

  describe 'relationships/validations' do
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

end

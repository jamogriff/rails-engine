require 'rails_helper'

RSpec.describe Merchant do

  describe 'relationships/validations' do
    it { should have_many(:items) }
  end
end

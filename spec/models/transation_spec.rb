require 'rails_helper'

RSpec.describe Transaction do

  describe 'model relationships' do
    it { should belong_to :invoice }
  end
end

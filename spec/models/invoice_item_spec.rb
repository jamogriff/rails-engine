require 'rails_helper'

RSpec.describe InvoiceItem do

  describe 'relationships/validations' do
    # there are other relationships here, but will filll in later
    it { should belong_to(:item) }
  end

end

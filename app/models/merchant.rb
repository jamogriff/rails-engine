class Merchant < ApplicationRecord
  has_many :items

  def self.find_by_name(search_params)
    Merchant.where("name ILIKE '%#{search_params}%'").limit(1).first
  end
end

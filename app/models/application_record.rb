class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.paginate(page = 1, per_page = 20)
    # Sets default values if user passes in 0
    # or negative numbers
    page = 1 if page.to_i < 1
    per_page = 20 if per_page.to_i < 1

    # Range of values returned from db is per_page * (page - 1)
    data_shift = per_page.to_i * (page.to_i - 1)
    self.offset(data_shift).limit(per_page.to_i)
  end
end

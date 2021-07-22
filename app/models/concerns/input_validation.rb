require 'date'

module InputValidation

  def self.date(raw_data)
    binding.pry
    Date.strptime(raw_data, "%Y-%m-%d")
  end
end

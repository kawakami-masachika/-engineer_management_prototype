class License < ApplicationRecord
  acts_as_paranoid

  belongs_to :employee
end

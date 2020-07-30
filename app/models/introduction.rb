class Introduction < ApplicationRecord
  acts_as_paranoid

  belongs_to :employee
end

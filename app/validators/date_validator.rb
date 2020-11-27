class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value[1].blank? || value[2].blank? || value[3].blank?
      record.errors.add(attribute, :invalid, options.merge(value: value))
    end
  end
end
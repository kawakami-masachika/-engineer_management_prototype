class DateFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    y,m,d = value.map{|i,d|d}
    unless Date.valid_date?(y,m,d)
      record.errors.add(attribute, :invalid, options.merge(value: value))
    end
  end
end
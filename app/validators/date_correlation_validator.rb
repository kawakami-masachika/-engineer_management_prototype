class DateCorrelationValidator < ActiveModel::Validator
  ERROR_MESSAGE = "は、参画開始日以降の日付を入力して下さい"
  def validate(record)
    start_date, end_date = options[:attributes].map{|date| Date.new(record.send(date)[1],record.send(date)[2],record.send(date)[3])}
    if start_date >= end_date
      record.errors.add(:leave_date, ERROR_MESSAGE)
    end
  end
end
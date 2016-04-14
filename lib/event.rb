class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date, :priority

  def initialize(description, options={})
    @description = description
    @start_date = Date.parse(options[:start_date]) if options[:start_date]
    @end_date = Date.parse(options[:end_date]) if options[:end_date]
  end

	def dates
		format_date(self.start_date, self.end_date)
	end

  def details
		format_description(self.description) + "event dates: " + dates
  end
end

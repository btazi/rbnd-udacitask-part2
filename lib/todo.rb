class TodoItem
	require 'chronic'
  include Listable
  attr_reader :description, :due
	attr_accessor	:priority

  def initialize(description, options={})
		puts options[:priority].nil?
		if (%w{low medium high}.include?(options[:priority]) || options[:priority].nil?)
			@description = description
			@due = Chronic.parse(options[:due]) if options[:due] 
			@priority = options[:priority]
		else
			raise UdaciListErrors::InvalidPriorityValue, "'#{options[:priority]}' is not a valid priority"
		end
  end

	def dates
		format_date(self.due)
	end

  def details
		format_description(self.description) + "due: " +
		dates +
		format_priority(self.priority)
  end
end

module Listable
	require 'colorize'
	def format_description(description)
		"#{description}".ljust(30)
	end

	def format_date(date_1=nil, date_2=nil)
			dates = date_1.strftime("%D") if date_1
			dates << " -- " + date_2.strftime("%D") if date_2
			dates = "N/A" if !dates
			return dates
	end

  def format_priority(priority)
		value = " ⇧".colorize(:red) if priority == "high"
		value = " ⇨".colorize(:blue) if priority == "medium"
		value = " ⇩".colorize(:green) if priority == "low"
    value = "" if !priority
    return value
  end

	def lower_priority
		self.priority = "medium" if self.priority == "low"
		self.priority = "high" if self.priority == "medium"
	end

	def higher_priority
		self.priority = "low" if self.priority == "medium"
		self.priority = "medium" if self.priority == "high"
	end

	def dates
	end

	def priority
	end
end

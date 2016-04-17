class UdaciList
	require 'terminal-table'
	require 'csv'
	require 'fileutils'
  attr_reader :title, :items

  def initialize(options={})
		@title = (options[:title] || "Untitled List")
    @items = []
  end

  def add(type, description, options={})
		if %w{todo event link}.include? type 
			type = type.downcase
			@items.push TodoItem.new(description, options) if type == "todo"
			@items.push EventItem.new(description, options) if type == "event"
			@items.push LinkItem.new(description, options) if type == "link"
		else
			raise UdaciListErrors::InvalidItemType, "'#{type}' is not a supported item type."
		end
  end

	def delete(index)
		if index <= @items.count
			@items.delete_at(index - 1)
		else
			raise UdaciListErrors::IndexExceededListSize, "Item does not exist"
		end
	end

	def print_in_table(list)
		rows = []
		list.each_with_index do |item, position|
			rows << [position + 1, formatted_item_type(item), item.details]
		end
		table = Terminal::Table.new title: @title, rows: rows
		puts table
	end

  def all
		print_in_table(@items)
  end

	def formatted_item_type(item)
		item.class.name.gsub("Item", "").downcase
	end

	def export
		path = "data/#{self.title}.csv"
		FileUtils.rm path if File.file?(path)
		CSV.open(path, "wb") do |csv|
			csv << ["#", "Type", "Description", "Due Date", "Priority" ]
			self.items.each_with_index do |item, position|
				csv << [position + 1, item.class.name, item.description, item.dates, item.priority]
			end
		end
	end

	def filter(item_type)
		@filtered_items = @items.select {|item| formatted_item_type(item) == item_type}
		print_in_table @filtered_items
	end
end

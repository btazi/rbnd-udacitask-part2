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

  def all
		rows = []
    @items.each_with_index do |item, position|
			rows << [position + 1, item.class.name, item.details]
    end
		table = Terminal::Table.new title: @title, rows: rows
		puts table
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
		@items.select {|item| item.class.name == item_type}
	end
end

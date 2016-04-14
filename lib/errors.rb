module UdaciListErrors
	class InvalidItemType < StandardError
	end

	class IndexExceededListSize < StandardError
	end

	class InvalidPriorityValue < StandardError
	end
end

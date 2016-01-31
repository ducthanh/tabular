class A
	attr_reader :status

	VALID_STATUS = %w{ INPROGRESS, DONE, REJECTED }

	def initialize(args)
		self.status = args[:status]
	end

	def status=(new_status)
		new_status = new_status.strip.upcase

		if VALID_STATUS.include? new_status
			@status = new_status
		else
			raise Error
		end
	end
end


class Bee
  @@tracker = nil

  def create
    @@tracker = 1
  end

  def self.get
    @@tracker
  end
end

n = Bee.new
n.create

puts Bee.get






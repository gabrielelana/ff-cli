module FF
  class Arguments
    def initialize(arguments, commands)
      @arguments = arguments
      @commands = commands
    end

    def adjust
      first_argument = @arguments.select {|a| not a.start_with?('-')}.first
      return @arguments if first_argument.nil? or @commands.include? first_argument
      @arguments[@arguments.index(first_argument)] = "--profile=#{first_argument}"
      @arguments
    end
  end
end

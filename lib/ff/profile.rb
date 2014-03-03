module FF
  class Profile
    attr_reader :name, :path
    def initialize(name, path)
      @name = name
      @path = path
    end

    def about
      puts "NAME: #{@name}"
      puts "PATH: #{@path}"
    end
  end
end

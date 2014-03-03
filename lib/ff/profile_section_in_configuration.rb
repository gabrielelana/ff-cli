module FF
  class ProfileSectionInConfiguration
    def initialize(section, root)
      @section = section
      @root = Pathname.new(root)
    end

    def profile?
      @section.has_key? 'Name' and @section.has_key? 'Path'
    end

    def relative?
      @section.fetch('IsRelative', '0') == '1'
    end

    def default?
      @section.fetch('Default', '0') == '1'
    end

    def name
      @section.fetch('Name')
    end

    def path
      @section.fetch('Path')
    end

    def absolute_path
      if relative?
        (@root + path).to_path
      else
        path
      end
    end

    def profile
      Profile.new(name, absolute_path)
    end
  end
end

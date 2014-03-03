require 'inifile'
require 'delegate'

require 'ff/profile'
require 'ff/profile_section_in_configuration.rb'

module FF

  class DefaultProfileNotFound < Exception; end
  class ProfileNotFound < Exception; end

  class Profiles
    def initialize(configuration, root)
      @configuration = IniFile.new(configuration)
      @root = root

      @profile_sections = profile_sections
    end

    def has_default?
      @configuration['General'].fetch('StartWithLastProfile') == '1'
    end

    def default
      raise DefaultProfileNotFound.new("No default profile found in '#{@root}'") unless has_default?
      create_profile_from_section(
        @profile_sections.detect do |section|
          section.default?
        end
      )
    end

    def select(name_or_path = nil)
      select_by_default(name_or_path) or
        select_by_name(name_or_path) or
        select_by_path(name_or_path) or
        raise ProfileNotFound.new("No profile '#{name_or_path}' found in '#{@root}'")
    end

    def create(name_or_path)
      raise 'Cannot create a profile yet'
    end

    def self.from(profiles_directory)
      raise "#{profiles_directory} doesn't exists" unless Dir.exists? profiles_directory
      profiles_file = File.join(profiles_directory, 'profiles.ini')
      configuration = File.exists?(profiles_file) ? File.read(profiles_file) : ''
      new(configuration, profiles_directory)
    end

    private

    def select_by_name(name)
      create_profile_from_section(
        @profile_sections.detect do |section|
          section.name == name
        end
      )
    end

    def select_by_path(path)
      create_profile_from_section(
        @profile_sections.detect do |section|
          section.path == path || section.absolute_path == path
        end
      )
    end

    def select_by_default(name_or_path)
      default if name_or_path.nil?
    end

    def create_profile_from_section(section)
      section.profile if section
    end

    def profile_sections
      @configuration.sections
        .map {|s| ProfileSectionInConfiguration.new(@configuration[s], @root)}
        .keep_if {|s| s.profile?}
    end
  end
end

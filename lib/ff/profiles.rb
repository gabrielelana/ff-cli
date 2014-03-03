require 'inifile'

module FF
  class DefaultProfileNotFound < ::Exception; end
  class Profiles
    def initialize(configuration, detected, root)
      @configuration = IniFile.new(configuration)
      @detected = detected
      @root = root
    end

    def has_default?
      @configuration['General'].fetch('StartWithLastProfile') == '1'
    end

    def default
      raise DefaultProfileNotFound.new("No default profile found in '#{@root}'") unless has_default?
      create_profile_from_section(
        profile_sections.detect do |section|
          section.fetch('Default', '0') == '1'
        end
      )
    end

    def profile_sections
      @configuration.sections
        .map {|s| @configuration[s]}
        .keep_if {|s| s.has_key? 'Name'}
    end

    def create_profile_from_section(section)
      FF::Profile.new(
        section.fetch('Name'),
        section.fetch('IsRelative', '0') == '1' ?
          (Pathname.new(@root) + section.fetch('Path')).to_path :
          section.fetch('Path')
      )
    end

    def self.from(profiles_directory)
      raise "#{profiles_directory} doesn't exists" unless Dir.exists? profiles_directory
      profiles_file = File.join(profiles_directory, 'profiles.ini')
      configuration =
        if File.exists? profiles_file
          File.read(profiles_file)
        else
          ''
        end
      detected_profiles = Pathname.glob("#{profiles_directory}/*/prefs.js").map {|p| p.parent.to_path}
      new(configuration, detected_profiles, profiles_directory)
    end
  end
end

require 'fileutils'

desc 'Destroy Firefox profile'
command :destroy do |c|
  c.action do |global_options,options,args|
    profile_path = File.join(FF::PROFILES_PATH, FF::PROFILES_PREFIX + global_options['profile'])
    FileUtils.rm_rf(profile_path) if Dir.exists?(profile_path)
    puts "[OK] destroyed profile '#{global_options['profile']}' (#{profile_path})"
  end
end


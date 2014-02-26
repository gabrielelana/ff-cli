require 'fileutils'

desc 'Destroy Firefox profile'
command :destroy do |c|

  c.desc 'Profile name'
  c.default_value 'default'
  c.arg_name 'name'
  c.flag [:p, :profile]

  c.action do |global_options,options,args|
    profile_path = File.join(FF::PROFILES_PATH, FF::PROFILES_PREFIX + options['profile'])
    FileUtils.rm_rf(profile_path) if Dir.exists?(profile_path)
    puts "[OK] destroyed profile '#{options['profile']}' (#{profile_path})"
  end
end


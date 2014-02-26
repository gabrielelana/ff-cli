desc 'Create Firefox profile'
command :create do |c|

  c.desc 'Profile name'
  c.default_value 'default'
  c.arg_name 'name'
  c.flag [:p, :profile]

  c.action do |global_options,options,args|
    profile_path = File.join(FF::PROFILES_PATH, FF::PROFILES_PREFIX + options['profile'])
    Dir.mkdir(profile_path, 0700) unless Dir.exists?(profile_path)
    puts "[OK] created profile '#{options['profile']}' (#{profile_path})"
  end
end

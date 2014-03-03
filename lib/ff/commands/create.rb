desc 'Create Firefox profile'
command :create do |c|
  c.action do |global_options,options,args|
    profile_path = File.join(FF::PROFILES_PATH, FF::PROFILES_PREFIX + global_options['profile'])
    Dir.mkdir(profile_path, 0700) unless Dir.exists?(profile_path)
    puts "[OK] created profile '#{global_options['profile']}' (#{profile_path})"
  end
end

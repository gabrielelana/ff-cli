desc 'Gives informations about Firefox profile'
command :about do |c|
  c.action do |global_options,options,args|
    profiles = FF::Profiles.from(FF::PROFILES_PATH)
    profiles.select(global_options[:profile]).about
  end
end

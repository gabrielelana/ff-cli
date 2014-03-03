desc 'Start Firefox with specified profile'
command :start do |c|
  c.action do |global_options,options,args|
    profile_path = File.join(FF::PROFILES_PATH, FF::PROFILES_PREFIX + global_options['profile'])
    puts "[OK] starting firefox in profile '#{global_options['profile']}' (#{profile_path})"
    child_pid = fork do
      [STDIN, STDOUT, STDERR].each do |io|
        io.reopen( "/dev/null", "r+" )
      end
      exec("#{FF::BINARY_PATH} --no-remote --profile #{profile_path}")
      exit!
    end
    Process.detach(child_pid)
  end
end

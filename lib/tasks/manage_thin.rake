def find_and_kill name
  Dir.glob("#{Rails.root}/tmp/pids/#{name}*").each do |file|     
    pid = File.read(file).to_i
    puts "killing thin server with pid #{pid}"
    Process.kill "INT", pid
  end
end

namespace :thin do
  desc "Stop thin servers"
    
  task :stop => :environment do
    find_and_kill "thin"
  end
end
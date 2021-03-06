require "bundler/setup"
Bundler.require


namespace :dev do

  desc "Generate the site in ./build/ from the files in ./src/."
  task :generate do
    system("cd src; stasis -p ../build/; cd ..")
  end


  desc "Auto-generation mode, open localhost:3000."
  task :auto_generate do
    puts "", "Development server running: http://localhost:3000"
    # Stasis::DevMode doesn't work as expected, dunno why.  Too lazy to dig
    # deeper right now.
    system("cd src; stasis -d 3000 -p ../build/; cd ..")
  end

end


namespace :git do

  desc "Commit regenerated build folder."
  task :commit_build do
    system("git commit -m '[NEW] Re-generated build folder.' build/")
  end

end


desc "Deploy to jiffybox."
task :deploy do
  system("scp -r build/* jiffybox:sites/servus.io/")
end

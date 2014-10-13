require_relative '../config/environment'

RSpec.configure do |config|
  config.before(:all) do
    FileUtils.rm_rf(Dir["spec/tmp/*"]) # remove pre-existing view files
  end
  config.after(:all) do
    FileUtils.rm_rf(Dir["spec/tmp/*"]) # remove created view files
  end
  config.order = 'default'
end

def get_paths(length)
  ["spec/support/#{length}.txt", "spec/tmp/#{length}_result.txt"]
end

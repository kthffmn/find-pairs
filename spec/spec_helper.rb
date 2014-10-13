require_relative '../config/environment'

RSpec.configure do |config|
  config.before(:all) do
    FileUtils.rm_rf(Dir["spec/results/*"]) # remove pre-existing view files
  end
  config.after(:all) do
    FileUtils.rm_rf(Dir["spec/results/*"]) # remove created view files
  end
  config.order = 'default'
end

def get_paths(length)
  ["spec/support/#{length}.txt", "spec/results/#{length}_result.txt"]
end

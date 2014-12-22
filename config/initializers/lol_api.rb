config_file = File.join(Rails.root, 'config', 'riot.yml')

unless File.exist?(config_file)
  raise "#{config_file} was not found."
end

config = YAML.load(File.read(config_file))
LolApi::Base.api_key = config['api_key']

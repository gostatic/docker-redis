require 'erb'

IMAGE_NAME = "gostatic/redis"
VERSIONS = [
  '3.2.11',
  '3.2.11-alpine',
  '4.0.2',
  '4.0.2-alpine',
]

def run_system_command(command)
  puts "  \e[33m#{command}\e[0m"
  IO.popen(command) do |io|
    while line = io.gets do
      puts "    \e[1;34m#{line.strip}\e[0m"
    end
  end
end

def build_version(version)
  raise "Please specify a version" unless (version && version != '')
  raise "Unknown version" unless VERSIONS.include?(version)
  puts "building #{version}"
  dockerfile_path = "Dockerfile-#{version}"
  dockerfile_template_path = "Dockerfile.erb"
  variables = {
    version: version,
  }
  struct = OpenStruct.new(variables)
  erb = ERB.new(File.read(dockerfile_template_path))
  dockerfile_content = erb.result(struct.instance_eval { binding })
  File.write(dockerfile_path, dockerfile_content)

  image_version = "#{IMAGE_NAME}:#{version}"
  run_system_command("docker build -t #{image_version} -f #{dockerfile_path} .")
end

def push_version(version)
  raise "Please specify a version" unless (version && version != '')
  raise "Unknown version" unless VERSIONS.include?(version)
  puts "pushing #{version}"

  image_version = "#{IMAGE_NAME}:#{version}"
  run_system_command("docker push #{image_version}")
end


desc 'Build version(s)'
task :build, [:version] do |_t, args|
  if ! args.version
    VERSIONS.each do |version|
      build_version(version)
    end
  else
    build_version(args.version)
  end
end

desc 'Push version(s)'
task :push, [:version] do |_t, args|
  if ! args.version
    VERSIONS.each do |version|
      push_version(version)
    end
  else
    push_version(args.version)
  end
end
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
  print "    \e[1;34m"
  IO.popen(command) do |io|
    while line = io.gets do
      print line.gsub("\n", "\n    ")
    end
  end
  puts "\e[0m"
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

desc 'Run version via interactive docker console'
task :run, [:version, :port, :role] do |_t, args|
  raise "Please specify a version" unless (args.version && args.version != '')
  raise "Unknown version" unless VERSIONS.include?(args.version)
  args.with_defaults(
    port: '16379',
    role: 'master',
  )
  run_system_command([
    "docker run -ti -p 16379:#{args.port}",
    "-v /tmp/gostatic-redis-#{args.role}:/data",
    "-e \"REDIS_PASS=S3CU4E\"",
    "gostatic/redis:#{args.version}",
    "redis-server /usr/local/etc/redis/redis-#{args.role}.conf",
  ].join(' '))
end

desc 'Cleanup temporary compiled file'
task :cleanup do
  files = Dir.glob('Dockerfile-*')
  files.each do |file|
    File.delete(file)
  end
end

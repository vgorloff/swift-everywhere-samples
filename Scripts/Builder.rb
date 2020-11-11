require 'yaml'
require 'fileutils'

class Builder

   def self.xcode()
      # puts "Environment"
      # puts ENV.each { |name, value| puts "#{name} -> #{value}" }
      # puts "Arguments"
      # puts ARGV
      Builder.new("x86_64").build()
   end

   def self.perform(arch)
      if arch.empty?
         Builder.new("armeabi-v7a").make()
         Builder.new("arm64-v8a").make()
         Builder.new("x86").make()
         Builder.new("x86_64").make()
      else
         Builder.new(arch).make()
      end
   end

   def initialize(arch)
      @isVerbose = false
      @root = File.expand_path(File.join(File.dirname(__FILE__), "../"))

      @package = File.join(@root, "Package")
      @arch = arch
      readConfig()

      if @arch == "armeabi-v7a"
         @target = "armv7-none-linux-androideabi"
      elsif @arch == "x86"
         @target = "i686-unknown-linux-android"
      elsif @arch == "arm64-v8a"
         @target = "aarch64-unknown-linux-android"
      elsif @arch == "x86_64"
         @target = "x86_64-unknown-linux-android"
      end
      @config = "release"
      @buildDir = "#{@root}/Android/app/build/swift-#{@arch}"
   end

   def readConfig
      settingsFilePath = "#{@root}/local.properties.yml"
      if File.exist?(settingsFilePath)
         @config = YAML.load_file(settingsFilePath)
      else
         raise "File \"#{settingsFilePath}\" not exists."
      end
      toolchainDir = @config['swiftToolchain.dir']
      if toolchainDir.nil?
         raise "Setting \"swiftToolchain.dir\" is missed in file \"#{settingsFilePath}\"."
      end

      @toolchainDir = File.expand_path(toolchainDir)
   end

   def make()
      build()
      copyLibs()
   end

   def build()
      @swiftBuild = @toolchainDir + "/usr/bin/android-swift-build --build-path \"#{@buildDir}\" -c #{@config} -target #{@target}"
      if @isVerbose
         @swiftBuild += " -v"
      end
      system "cd #{@package} && #{@swiftBuild}"
   end

   def copyLibs()
      @copyLibsCmd = @toolchainDir + "/usr/bin/android-copy-libs -target #{@target}"
      if @isVerbose
         @copyLibsCmd += " -v"
      end
      @builds = "#{@root}/Android/app/src/main/jniLibs/#{@arch}"
      system "mkdir -p \"#{@builds}\""
      system "#{@copyLibsCmd} -output #{@builds}"
      libs = Dir["#{@buildDir}/#{@config}/**/*.so"]
      libs.each { |lib|
         dst = File.join(@builds, File.basename(lib))
         if !FileUtils.uptodate?(dst, [lib])
            if @isVerbose
               puts "- Copying \"#{lib}\" to \"#{dst}\""
            end
            FileUtils.copy_entry(lib, dst, false, false, true)
         end
      }
   end

   def execute(command)
      print(command, 32) # Green color.
      if system(command) != true
         message "Execution of command is failed:"
         error command
         puts
         help = <<EOM
If error was due Memory, CPU, or Disk peak resource usage (i.e. missed file while file exists),
then try to run previous command again. Build process will perform `configure` step again,
but most of compilation steps will be skipped.
EOM
         message help
         raise
      end
   end

   def print(message, color = 32)
      # See: Colorized Ruby output – https://stackoverflow.com/a/11482430/1418981
      puts "\e[#{color}m#{message}\e[0m"
   end

   def message(command)
      print(command, 36) # Light blue color.
   end

   def error(command)
      print(command, 31) # Red color.
   end

end

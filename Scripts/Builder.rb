require 'yaml'
require 'fileutils'
require_relative "Tool.rb"

class Builder < Tool

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
      @swiftBuild = @toolchainDir + "/bin/android-swift-build --build-path \"#{@buildDir}\" -c #{@config} --android-target #{@target}"
      if @isVerbose
         @swiftBuild += " -v"
      end
      system "cd #{@package} && #{@swiftBuild}"
   end

   def copyLibs()
      @copyLibsCmd = @toolchainDir + "/bin/android-copy-libs --android-target #{@target}"
      if @isVerbose
         @copyLibsCmd += " -v"
      end
      @builds = "#{@root}/Android/app/src/main/jniLibs/#{@arch}"
      system "mkdir -p \"#{@builds}\""
      system "#{@copyLibsCmd} #{@builds}"
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

end

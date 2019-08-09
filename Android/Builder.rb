require 'yaml'
require 'fileutils'
require_relative "../Scripts/Tool.rb"

class Builder < Tool

   def self.xcode()
      # puts "Environment"
      # puts ENV.each { |name, value| puts "#{name} -> #{value}" }
      # puts "Arguments"
      # puts ARGV
      perform("armeabi-v7a")
   end

   def self.perform(arch)
      if arch.empty?
         Builder.new("armeabi-v7a").build()
         Builder.new("arm64-v8a").build()
         Builder.new("x86").build()
         Builder.new("x86_64").build()
      else
         Builder.new(arch).build()
      end
   end

   def initialize(arch)
      @isVerbose = false
      @root = File.dirname(__FILE__)
      @package = File.join(@root, "../Package")
      @arch = arch
      @builds = "#{@root}/app/build/swift/#{arch}"

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
      @buildDir = "#{@root}/app/build/swift-#{@arch}"
      @swiftBuild = @toolchainDir + "/bin/android-swift-build --build-path \"#{@buildDir}\" -c #{@config} --android-target #{@target}"
      @copyLibsCmd = @toolchainDir + "/bin/android-copy-libs --android-target #{@target}"
      if @isVerbose
         @copyLibsCmd += " -v"
         @swiftBuild += " -v"
      end
   end

   def build()
      system "mkdir -p \"#{@builds}\""
      system "cd #{@package} && #{@swiftBuild}"
      copyLibs
      libs = Dir["#{@buildDir}/#{@config}/**/*.so"]
      libs.each { |lib|
         dst = File.join(@builds, File.basename(lib))
         FileUtils.copy_entry(lib, dst, false, false, true)
      }
   end

   def copyLibs()
      system "#{@copyLibsCmd} #{@builds}"
   end

end

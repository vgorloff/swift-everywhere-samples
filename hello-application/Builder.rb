require 'yaml'
require_relative "../Scripts/Tool.rb"

class Builder < Tool

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
      @root = File.dirname(__FILE__)
      @arch = arch
      @sources = "#{@root}/Sources"
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
         @ndkArchPath = "arm-linux-androideabi"
      elsif @arch == "x86"
         @ndkArchPath = "i686-linux-android"
      elsif @arch == "arm64-v8a"
         @ndkArchPath = "aarch64-linux-android"
      elsif @arch == "x86_64"
         @ndkArchPath = "x86_64-linux-android"
      end
      @swiftc = @toolchainDir + "/bin/swiftc-" + @ndkArchPath
      @copyLibsCmd = @toolchainDir + "/bin/copy-libs-" + @ndkArchPath
   end

   def build()
      execute "mkdir -p \"#{@builds}\""
      binary = "#{@builds}/libHelloMessages.so"
      sources = Dir["#{@sources}/*.swift"].join(" ")
      execute "cd #{@builds} && #{@swiftc} -emit-library -parse-as-library -module-name HelloMessages -o #{binary} #{sources}"
      copyLibs
   end

   def copyLibs()
      execute "#{@copyLibsCmd} #{@builds}"
   end

end

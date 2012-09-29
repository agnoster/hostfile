require "hostfile/version"
require "hostfile/hostfile"

module Hostfile
  def self.windows?
    RbConfig::CONFIG['host_os'] =~ /mswin|windows|mingw/i
  end

  def self.system_path
    windows? ? (ENV['SystemRoot'] + '\system32\drivers\etc\hosts') : '/etc/hosts'
  end

  def self.default
    Hostfile.new
  end

  def self.new(*args)
    Hostfile.new(*args)
  end
end

require "hostfile/version"
require "hostfile/hosts"

module Hostfile
  def self.windows?
    RbConfig::CONFIG['host_os'] =~ /mswin|windows|mingw/i
  end

  def self.system_path
    windows? ? (ENV['SystemRoot'] + '\system32\drivers\etc\hosts') : '/etc/hosts'
  end

  def self.default(&block)
    open(&block)
  end

  def self.open(path=nil, &block)
    path ||= system_path
    hosts = Hosts.new(path)
    if block
      yield hosts
    else
      hosts
    end
  end
end

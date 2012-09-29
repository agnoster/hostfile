module Hostfile
  class Hosts < Hash
    attr_accessor :path

    def initialize(path)
      @path = path
    end

    def ==(hosts)
      if hosts.is_a? Hosts
        path == hosts.path
      else
        super hosts
      end
    end
  end
end

module Hostfile
  class Hostfile < Hash
    attr_accessor :path

    def initialize(path=nil)
      @path ||= ::Hostfile.system_path
    end
  end
end

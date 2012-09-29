require 'spec_helper'

describe Hostfile do
  describe "#new" do
    context "with no arguments" do
      let :hosts do
        subject.new
      end

      it "should instantiate a new Hostfile" do
        expect(hosts).to be_a Hostfile::Hostfile
      end

      it "should have the default path" do
        expect(hosts.path).to eql Hostfile.system_path
      end
    end
  end

  describe "#system_path" do
    context "on windows" do
      before :each do
        ENV['SystemRoot'] = 'C:\WINDOWS'
        Hostfile.stub(:windows?).and_return true
      end

      it "returns the right path" do
        expect(Hostfile.system_path).to eql 'C:\WINDOWS\system32\drivers\etc\hosts'
      end
    end

    context "by default" do
      before :each do
        Hostfile.stub(:windows?).and_return false
      end

      it "returns the right path" do
        expect(Hostfile.system_path).to eql '/etc/hosts'
      end
    end
  end
end

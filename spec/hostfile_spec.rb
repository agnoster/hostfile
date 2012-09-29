require 'spec_helper'

describe Hostfile do
  describe "#==" do
    let :hosts do
      subject.open 'spec/hosts.equality.example'
    end

    context "comparing to another Hostfile" do
      context "with the same path" do
        let :other_hosts do
          subject.open hosts.path
        end

        it "returns true" do
          expect(hosts == other_hosts).to be_true
        end
      end

      context "with a different path" do
        let :other_hosts do
          subject.open "/foo/bar"
        end

        it "returns false" do
          expect(hosts == other_hosts).to be_false
        end
      end
    end
  end

  describe "#open" do
    context "with no arguments" do
      let :hosts do
        subject.open
      end

      it "should instantiate a new Hostfile" do
        expect(hosts).to be_a Hostfile::Hostfile
      end

      it "should have the default path" do
        expect(hosts.path).to eql Hostfile.system_path
      end
    end

    context "with a path" do
      let :path do
        'spec/hosts.equality.example'
      end

      let :hosts do
        subject.open path
      end

      it "should instantiate a new Hostfile" do
        expect(hosts).to be_a Hostfile::Hostfile
      end

      it "should have the given path" do
        expect(hosts.path).to eql path
      end

      context "in block context" do
        it "calls the block with the Hostfile" do
          result = nil
          subject.open path do |h|
            result = h
          end
          expect(result).to eql hosts
        end

        it "returns the value of the block" do
          result = subject.open path do |h|
            "Result from block"
          end
          expect(result).to eql "Result from block"
        end
      end
    end
  end

  describe "#default" do
    let :hosts do
      subject.default
    end

    it "returns the same as #open with no args" do
      expect(hosts).to eql Hostfile.open
    end

    it "also works in block form" do
      result = nil
      subject.default do |h|
        result = h
      end
      expect(result).to eql hosts
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

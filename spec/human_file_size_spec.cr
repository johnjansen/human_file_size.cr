require "./spec_helper"
require "yaml"
require "json"

class ConverterTest
  getter :file_size

  YAML.mapping(
    file_size: {
      type:      BigFloat,
      converter: HumanFileSize,
    }
  )

  JSON.mapping(
    file_size: {
      type:      BigFloat,
      converter: HumanFileSize,
    }
  )

  @file_size : BigFloat?

  def initialize(@file_size : BigFloat)
  end
end

TESTS = {
  "1 B" => 1,
  "1 KB" => 1000,
  "1.50 KB" => 1500,
  "1 MB" => 1000000,
  "0.50 MB" => 500000,
  "1 GB" => 1000000000,
  "1 TB" => 1000000000000,
  "1 PB" => 1000000000000000,
  "1 EB" => 1000000000000000000,
  "1 ZB" => BigFloat.new("1000000000000000000000"),
  "1 YB" => BigFloat.new("1000000000000000000000000")
}

describe HumanFileSize do
  it "should convert words to numbers" do
    TESTS.each do |k, v|
      test_hash = {:file_size => k}
      HumanFileSize.to_f(k).should eq v
      ConverterTest.from_yaml(test_hash.to_yaml).file_size.should eq v
      ConverterTest.from_json(test_hash.to_json).file_size.should eq v
    end
  end

  it "should convert numbers to words" do
    TESTS.each do |k, v|
      ct = ConverterTest.new(v.to_big_f)
      HumanFileSize.to_s(v, k.split(" ").last).should eq k
      JSON.parse(ct.to_json)["file_size"].should eq "#{v} B"
      YAML.parse(ct.to_yaml)["file_size"].should eq "#{v} B"
    end
  end
end

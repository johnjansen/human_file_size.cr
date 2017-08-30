require "big_float"
require "./human_file_size/*"

module HumanFileSize
  MULTIPLIERS = %w{B KB MB GB TB PB EB ZB YB}
  PATTERN     = /(#{MULTIPLIERS.join("|")})$/i

  # ffhdshkj
  def self.to_f(str : String) : BigFloat
    times = 1
    size_basic = str.sub(PATTERN) do |m|
      mp = MULTIPLIERS.index(m)
      raise "invalid format" if mp.nil?
      times = mp == 0 ? 1 : (1000.to_big_f ** mp)
      ""
    end
    size_basic.to_big_f * times
  end

  # uufdsjh
  def self.to_s(number : Number, format : String = "B")
    if format == "B"
      "#{number} B"
    else
      short = (number / (1000.to_f ** MULTIPLIERS.index(format).not_nil!)).round(2)

      if short == short.round(0)
        sprintf "%i #{format}", short
      else
        sprintf "%0.2f #{format}", short
      end
    end
  end

  def self.to_json(value : Number, json : JSON::Builder)
    json.scalar to_s(value)
  end

  def self.from_json(value : JSON::PullParser) : Number
    to_f(value.read_string)
  end

  def self.to_yaml(value : Number, yaml : YAML::Builder)
    yaml.scalar to_s(value)
  end

  def self.from_yaml(value : YAML::PullParser) : Number
    to_f(value.read_scalar)
  end
end

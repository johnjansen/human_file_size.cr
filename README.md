# human_file_size

[![Build Status](https://travis-ci.org/johnjansen/human_file_size.cr.svg?branch=master)](https://travis-ci.org/johnjansen/human_file_size.cr)
serializes and deserializes file sizes (in human readable format), within json or yaml mappings

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  human_file_size:
    github: johnjansen/human_file_size.cr
```

## Usage

```crystal
require "human_file_size"

class ConverterExample
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
end

ce = ConverterExample.from_yaml("file_size: \"1 KB\"")
ce.to_yaml => "1000 B" # always writes as bytes at the moment
```

## Contributing

1. Fork it ( https://github.com/johnjansen/human_file_size.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [johnjansen](https://github.com/johnjansen) John Jansen - creator, maintainer

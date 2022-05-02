# libjq.cr

[Crystal](http://crystal-lang.org/) bindings for libjq.

- crystal: `0.33.0` .. `1.2.2`

WARNING: This project is in alpha stage. Currently, this should only be used for short-term applications due to memory leaks.

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  libjq:
    github: maiha/libjq
    version: 0.2.0
```

2. Run `shards install`

Make sure that `libjq.{a,so}` is on your system.
For example, on ubuntu, you can install it with `apt install libjq-dev`.

## Usage

```crystal
require "libjq"

filter = ".foo"
input  = %({"foo": 42, "bar": 43})
Libjq::Jq.run(filter, input).to_s # => 42

filter = %(with_entries(.key |= "KEY_" + .))
input  = %({"a": 1, "b": 2})
Libjq::Jq.run(filter, input).to_s # => {"KEY_a":1,"KEY_b":2}
```

See [examples/jq.cr](./examples/jq.cr)

## Development

```console
$ make test
```

## Contributing

1. Fork it (<https://github.com/maiha/libjq.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) - creator and maintainer

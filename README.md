# esnext for Ruby

This library is a Ruby bridge to the official esnext compiler.

```ruby
Esnext.compile File.read("script.js")
```


## Installation

```
gem install esnext
```


## Dependencies

This library vendors esnext.js, a bundled standalone version that can run in
any JS environment.  In addition, you can use this library with any version of
esnext by setting the `ESNEXT_SOURCE_PATH` environment variable:

    export ESNEXT_SOURCE_PATH=/path/to/esnext.js

### ExecJS

The [ExecJS](https://github.com/sstephenson/execjs) library is used to
automatically choose the best JavaScript engine for your platform. Check out
its [README](https://github.com/sstephenson/execjs/blob/master/README.md) for a
complete list of supported engines.

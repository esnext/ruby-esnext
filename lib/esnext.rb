require 'execjs'

module Esnext
  Error            = ExecJS::Error
  EngineError      = ExecJS::RuntimeError
  CompilationError = ExecJS::ProgramError

  module Source
    def self.path
      @path ||= ENV['ESNEXT_SOURCE_PATH'] || bundled_path
    end

    def self.path=(path)
      @contents = @version = @context = nil
      @path = path
    end

    def self.bundled_path
      File.expand_path('../../vendor/esnext.js', __FILE__)
    end

    def self.contents
      @contents ||= File.read(path)
    end

    def self.version
      @version ||= contents[/esnext v([\d.]+)/, 1]
    end

    def self.context
      @context ||= ExecJS.compile(contents)
    end
  end

  class CompileResult
    attr_accessor :code, :map

    def initialize(code, map)
      @code = code
      @map = map
    end
  end

  class << self
    def engine
    end

    def engine=(engine)
    end

    def version
      Source.version
    end

    # Compile a script (String or IO) from future JavaScript.
    def compile(script, options = {})
      script = script.read if script.respond_to?(:read)
      result = Source.context.call('esnext.compile', script, normalize_options(options))
      CompileResult.new(result.fetch('code'), result.fetch('map', nil))
    end

    private

    # Convert Ruby-style options to JS-style options, e.g. 'includeRuntime'.
    def normalize_options(options={})
      options.inject({}) do |result, (key,value)|
        result[key.to_s.gsub(/_([a-z])/) { $1.upcase }] = value
        result
      end
    end
  end
end

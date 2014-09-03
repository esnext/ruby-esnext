begin
  require 'minitest/autorun'
rescue LoadError
  require 'test/unit'
end

TestCase = if defined? Minitest::Test
    Minitest::Test
  elsif defined? MiniTest::Unit::TestCase
    MiniTest::Unit::TestCase
  else
    Test::Unit::TestCase
  end

require 'esnext'
require 'stringio'

class TestEsnext < TestCase
  def test_compile
    assert_match "var f = function()",
      Esnext.compile("var f = () => {};").code
  end

  def test_compile_with_io
    io = StringIO.new("var f = () => {};")
    assert_match "var f = function()",
      Esnext.compile(io).code
  end

  def test_without_arrow_function
    assert_match "function A()",
      Esnext.compile("class A {}").code

    assert_match "class A {}",
      Esnext.compile("class A {}", :class => false).code
  end

  def test_with_runtime
    assert_match "function wrapGenerator(",
      Esnext.compile("", :include_runtime => true).code
  end

  def test_compilation_error
    begin
      Esnext.compile("var sayHello = =>;")
      flunk
    rescue Esnext::Error => e
      assert_equal "Error: Line 1: Unexpected token =>", e.message
    end
  end

  def test_run_result
    code = Esnext.compile(<<-JS).code
    function add(...ns) {
      return ns.reduce((sum, n) => sum + n, 0);
    }
    JS

    context = ExecJS.compile(code)
    assert_equal context.call('add', 1, 2, 3, 4), 10
  end
end

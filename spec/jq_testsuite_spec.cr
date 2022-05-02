require "./spec_helper"
require "json"

testdata = "tests/jq.test"

describe testdata do
  tests = TestCase.load(testdata)

  tests.each do |test|
    prog  = test.program.data
    input = test.input.data
      
    label = %(%s: %-30s => %s) % [test.program.lineno, prog[0,30], test.expected.to_s.chomp[0,50]]

    if test.must_fail? || test.module_system?
      pending label
      next
    end

    it label do
      exp = test.expected
      if msg = exp.error_message
        begin
          Libjq::Jq.run(prog, input)
        rescue err
          err.to_s.should eq(msg)
        end
      else
        got = Libjq::Jq.run(prog, input).to_s.chomp

        # Trim spaces to check equality JSON such as;
        #   {"x":-1} and {"x": -1}
        #   [1,2,3]  and [1, 2, 3]
        s1 = got.gsub(/([:,]) /, "\\1")
        s2 = exp.data.gsub(/([:,]) /, "\\1")
        s1.should eq(s1)
      end
    end

  end
end

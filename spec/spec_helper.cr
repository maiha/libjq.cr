require "spec"
require "../src/libjq"

record Line, lineno : Int32, data : String, null : Bool = false do
  def to_s(io : IO)
    if null
      io << "(null)"
    else
      io << data
    end
  end
end

record Expected,
       lines : Array(Line) = Array(Line).new,
       error_message : String? = nil do

  def data : String
    lines.map(&.data).join("\n")
  end
  
  def empty? : Bool
    error_message == nil && lines.empty?
  end

  def to_s(io : IO)
    if empty?
      io << "(empty)"
    elsif msg = error_message
      io << msg
    elsif lines.size == 1
      io << lines.first.to_s
    else
      io << "%s (%d lines)" % [lines[0]?.try(&.to_s), lines.size]
    end
  end
end

record TestCase,
       program : Line,
       input : Line,
       expected : Expected

struct TestCase
  enum State
    EXPECT_PROG
    EXPECT_INPUT
    EXPECT_DATA
  end

  MARKER_FAIL            = "%%FAIL"
  MARKER_FAIL_IGNORE_MSG = "%%FAIL IGNORE MSG"

  MODULE_SYSTEM_REGEX = /^(import |include )/

  def must_fail? : Bool
    case program.data
    when MARKER_FAIL
      return true
    when MARKER_FAIL_IGNORE_MSG
      return true
    else
      return false
    end
  end

  def module_system? : Bool
    case program.data
    when MODULE_SYSTEM_REGEX
      return true
    else
      return false
    end
  end

  def self.load(full_path : String) : Array(TestCase)
    tests = Array(TestCase).new
    state = State::EXPECT_PROG
    prog  : Line? = nil
    input : Line? = nil
    data  : Expected = Expected.new
    
    lineno = 0
    flush = -> {
      if prog && input && (!data.empty? || input.not_nil!.null)
        tests << TestCase.new(prog.not_nil!, input.not_nil!, data)
        state = State::EXPECT_PROG
        prog = input = nil
        data = Expected.new
      elsif !prog && !input
        # ignore newlines
      else
        raise "#{lineno}: broken testsuite [prog=#{prog}, input=#{input}, data=#{data}]"
      end
    }

    File.each_line(full_path) do |line|
      lineno += 1

      case line
      when /^$/
        case state
        when .expect_prog?, .expect_data?
          flush.call
          next
        when .expect_input?
          raise "#{lineno}: #{state}, but got NEWLINE"
        else
          raise "BUG: unknown state: #{state}"
        end

      else
        case state
        when .expect_prog?
          next if line.starts_with?("#")
          prog && raise "#{lineno}: BUG: expected new program, but unfinished program exists. (#{prog})"
          prog = Line.new(lineno, line)
          state = State::EXPECT_INPUT
        when .expect_input?
          raise "#{lineno}: expected input, but got '#'." if line.starts_with?("#")
          prog  || raise "#{lineno}: BUG: expected program, but not found."
          input && raise "#{lineno}: BUG: expected new input, but unfinished input exists. (#{input})"
          input = Line.new(lineno, line, null: ("null" == line))
          state = State::EXPECT_DATA
        when .expect_data?
          prog  || raise "#{lineno}: BUG: expected program, but not found."
          input || raise "#{lineno}: BUG: expected input, but not found."

          if line.starts_with?("#")
            if data.empty?
              data = Expected.new(error_message: line[1..-1])
            else
              raise "#{lineno}: comment found while expecting data. (data=#{data.inspect})"
            end
          else
            if data.error_message
              raise "#{lineno}: data found, but it is already marked as error. (data=#{data.inspect})"
            else
              data.lines << Line.new(lineno, line)
            end
          end
        else
          raise "BUG: unknown state: #{state}"
        end
      end
    end

    flush
    return tests
  end
end

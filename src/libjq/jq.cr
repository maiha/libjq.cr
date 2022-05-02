# patch for LibJq
class Libjq::Jq
  alias State = LibJq::JqState
  alias Jv = LibJq::Jv

  # use `class` rather than `struct` in order to invoke finalizer
  property jq : State
  property results : Array(String)
  property debug : Bool = false

  def initialize
    @jq = LibJq.jq_init
    @results = Array(String).new

    GC.add_finalizer(self)
  end

  def <<(s : String)
    results << s
  end

  def run(filter : String, input : String)
    # No needs for 'input_state' because we accept only string as input.
    # input_state = LibJq.jq_util_input_init(nil, nil) # XXX add err_cb
    
    compiled = LibJq.jq_compile(jq, filter)
    if compiled == 0
      raise "jq error: jq_compile"
    end

    parser = LibJq.jv_parser_new(0)
    LibJq.jv_parser_set_buf(parser, input, input.bytesize, 0)

    while true
      value = LibJq.jv_parser_next(parser)
      Jq.valid?(value) || break

      LibJq.jq_start(jq, value, 0)

      while true
        result = LibJq.jq_next(jq)
        Jq.valid?(result) || break
        self << Jq.stringify(result)
      end
    end
  end
  
  def to_s(io : IO)
    results.each do |r|
      io.puts r.to_s
    end
  end

  def finalize
    # LibJq.jq_teardown(jq.as(Pointer(LibJq::JqState)))

    # FIX ME: This causes error;
    #   src/execute.c:177: stack_pop: Assertion `jv_is_valid(val)' failed.
  end

  ######################################################################
  ### static utility methods
  
  # static int jv_is_valid(jv x) { return jv_get_kind(x) != JV_KIND_INVALID; }
  def self.valid?(jv : LibJq::Jv) : Bool
    return LibJq.jv_get_kind(jv) != LibJq::JvKind::JV_KIND_INVALID
  end

  def self.stringify(jv : LibJq::Jv) : String
    dump = LibJq.jv_dump_string(LibJq.jv_copy(jv), 0)
    ptr  = LibJq.jv_string_value(dump)

    # Crystal uses raw pointer directly?
    # LibJq.jv_free(dump)
    return String.new(ptr)
  end

  def self.equal?(s1 : String, s2 : String) : Bool
    jv1 = LibJq.jv_string(s1)
    jv2 = LibJq.jv_string(s2)
    return LibJq.jv_equal(jv1, jv2) == 1
  end

  def self.run(*args, **opts)
    jq = new
    jq.run(*args, **opts)
    return jq
  end
end

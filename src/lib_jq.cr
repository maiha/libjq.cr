@[Link("jq")]
lib LibJq
  alias JvRefcnt = Void
  fun jv_get_kind(x0 : Jv) : JvKind
  struct Jv
    kind_flags : UInt8
    pad_ : UInt8
    offset : LibC::UShort
    size : LibC::Int
    u : JvU
  end
  union JvU
    ptr : JvRefcnt*
    number : LibC::Double
  end
  enum JvKind
    JV_KIND_INVALID = 0
    JV_KIND_NULL    = 1
    JV_KIND_FALSE   = 2
    JV_KIND_TRUE    = 3
    JV_KIND_NUMBER  = 4
    JV_KIND_STRING  = 5
    JV_KIND_ARRAY   = 6
    JV_KIND_OBJECT  = 7
  end
  fun jv_kind_name(x0 : JvKind) : LibC::Char*
  fun jv_is_valid(x : Jv) : LibC::Int
  fun jv_copy(x0 : Jv) : Jv
  fun jv_free(x0 : Jv)
  fun jv_get_refcnt(x0 : Jv) : LibC::Int
  fun jv_equal(x0 : Jv, x1 : Jv) : LibC::Int
  fun jv_identical(x0 : Jv, x1 : Jv) : LibC::Int
  fun jv_contains(x0 : Jv, x1 : Jv) : LibC::Int
  fun jv_invalid : Jv
  fun jv_invalid_with_msg(x0 : Jv) : Jv
  fun jv_invalid_get_msg(x0 : Jv) : Jv
  fun jv_invalid_has_msg(x0 : Jv) : LibC::Int
  fun jv_null : Jv
  fun jv_true : Jv
  fun jv_false : Jv
  fun jv_bool(x0 : LibC::Int) : Jv
  fun jv_number(x0 : LibC::Double) : Jv
  fun jv_number_value(x0 : Jv) : LibC::Double
  fun jv_is_integer(x0 : Jv) : LibC::Int
  fun jv_array : Jv
  fun jv_array_sized(x0 : LibC::Int) : Jv
  fun jv_array_length(x0 : Jv) : LibC::Int
  fun jv_array_get(x0 : Jv, x1 : LibC::Int) : Jv
  fun jv_array_set(x0 : Jv, x1 : LibC::Int, x2 : Jv) : Jv
  fun jv_array_append(x0 : Jv, x1 : Jv) : Jv
  fun jv_array_concat(x0 : Jv, x1 : Jv) : Jv
  fun jv_array_slice(x0 : Jv, x1 : LibC::Int, x2 : LibC::Int) : Jv
  fun jv_array_indexes(x0 : Jv, x1 : Jv) : Jv
  fun jv_string(x0 : LibC::Char*) : Jv
  fun jv_string_sized(x0 : LibC::Char*, x1 : LibC::Int) : Jv
  fun jv_string_empty(len : LibC::Int) : Jv
  fun jv_string_length_bytes(x0 : Jv) : LibC::Int
  fun jv_string_length_codepoints(x0 : Jv) : LibC::Int
  fun jv_string_hash(x0 : Jv) : LibC::ULong
  fun jv_string_value(x0 : Jv) : LibC::Char*
  fun jv_string_indexes(j : Jv, k : Jv) : Jv
  fun jv_string_slice(j : Jv, start : LibC::Int, _end : LibC::Int) : Jv
  fun jv_string_concat(x0 : Jv, x1 : Jv) : Jv
  fun jv_string_vfmt(x0 : LibC::Char*, x1 : VaList) : Jv
  alias X__GnucVaList = LibC::VaList
  alias VaList = X__GnucVaList
  fun jv_string_fmt(x0 : LibC::Char*, ...) : Jv
  fun jv_string_append_codepoint(a : Jv, c : Uint32T) : Jv
  alias X__Uint32T = LibC::UInt
  alias Uint32T = X__Uint32T
  fun jv_string_append_buf(a : Jv, buf : LibC::Char*, len : LibC::Int) : Jv
  fun jv_string_append_str(a : Jv, str : LibC::Char*) : Jv
  fun jv_string_split(j : Jv, sep : Jv) : Jv
  fun jv_string_explode(j : Jv) : Jv
  fun jv_string_implode(j : Jv) : Jv
  fun jv_object : Jv
  fun jv_object_get(object : Jv, key : Jv) : Jv
  fun jv_object_has(object : Jv, key : Jv) : LibC::Int
  fun jv_object_set(object : Jv, key : Jv, value : Jv) : Jv
  fun jv_object_delete(object : Jv, key : Jv) : Jv
  fun jv_object_length(object : Jv) : LibC::Int
  fun jv_object_merge(x0 : Jv, x1 : Jv) : Jv
  fun jv_object_merge_recursive(x0 : Jv, x1 : Jv) : Jv
  fun jv_object_iter(x0 : Jv) : LibC::Int
  fun jv_object_iter_next(x0 : Jv, x1 : LibC::Int) : LibC::Int
  fun jv_object_iter_valid(x0 : Jv, x1 : LibC::Int) : LibC::Int
  fun jv_object_iter_key(x0 : Jv, x1 : LibC::Int) : Jv
  fun jv_object_iter_value(x0 : Jv, x1 : LibC::Int) : Jv
  fun jv_get_refcnt(x0 : Jv) : LibC::Int
  fun jv_dumpf(x0 : Jv, f : File*, flags : LibC::Int)
  struct X_IoFile
    _flags : LibC::Int
    _io_read_ptr : LibC::Char*
    _io_read_end : LibC::Char*
    _io_read_base : LibC::Char*
    _io_write_base : LibC::Char*
    _io_write_ptr : LibC::Char*
    _io_write_end : LibC::Char*
    _io_buf_base : LibC::Char*
    _io_buf_end : LibC::Char*
    _io_save_base : LibC::Char*
    _io_backup_base : LibC::Char*
    _io_save_end : LibC::Char*
    _markers : X_IoMarker*
    _chain : X_IoFile*
    _fileno : LibC::Int
    _flags2 : LibC::Int
    _old_offset : X__OffT
    _cur_column : LibC::UShort
    _vtable_offset : LibC::Char
    _shortbuf : LibC::Char[1]
    _lock : X_IoLockT*
    _offset : X__Off64T
    _codecvt : X_IoCodecvt*
    _wide_data : X_IoWideData*
    _freeres_list : X_IoFile*
    _freeres_buf : Void*
    __pad5 : LibC::SizeT
    _mode : LibC::Int
    _unused2 : LibC::Char[20]
  end
  type File = X_IoFile
  alias X_IoMarker = Void
  alias X__OffT = LibC::Long
  alias X_IoLockT = Void
  alias X__Off64T = LibC::Long
  alias X_IoCodecvt = Void
  alias X_IoWideData = Void
  fun jv_dump(x0 : Jv, flags : LibC::Int)
  fun jv_show(x0 : Jv, flags : LibC::Int)
  fun jv_dump_string(x0 : Jv, flags : LibC::Int) : Jv
  fun jv_dump_string_trunc(x : Jv, outbuf : LibC::Char*, bufsize : LibC::SizeT) : LibC::Char*
  fun jv_parse(string : LibC::Char*) : Jv
  fun jv_parse_sized(string : LibC::Char*, length : LibC::Int) : Jv
  fun jv_nomem_handler(x0 : JvNomemHandlerF, x1 : Void*)
  alias JvNomemHandlerF = (Void* -> Void)
  fun jv_load_file(x0 : LibC::Char*, x1 : LibC::Int) : Jv
#  alias JvParser = Void
  fun jv_parser_new(x0 : LibC::Int) : JvParser
  type JvParser = Void*
  fun jv_parser_set_buf(x0 : JvParser, x1 : LibC::Char*, x2 : LibC::Int, x3 : LibC::Int)
  fun jv_parser_remaining(x0 : JvParser) : LibC::Int
  fun jv_parser_next(x0 : JvParser) : Jv
  fun jv_parser_free(x0 : JvParser)
  fun jv_get(x0 : Jv, x1 : Jv) : Jv
  fun jv_set(x0 : Jv, x1 : Jv, x2 : Jv) : Jv
  fun jv_has(x0 : Jv, x1 : Jv) : Jv
  fun jv_setpath(x0 : Jv, x1 : Jv, x2 : Jv) : Jv
  fun jv_getpath(x0 : Jv, x1 : Jv) : Jv
  fun jv_delpaths(x0 : Jv, x1 : Jv) : Jv
  fun jv_keys(x0 : Jv) : Jv
  fun jv_keys_unsorted(x0 : Jv) : Jv
  fun jv_cmp(x0 : Jv, x1 : Jv) : LibC::Int
  fun jv_group(x0 : Jv, x1 : Jv) : Jv
  fun jv_sort(x0 : Jv, x1 : Jv) : Jv
#  alias JqState = Void
  fun jq_init : JqState
  type JqState = Void*
  fun jq_set_error_cb(x0 : JqState, x1 : JqMsgCb, x2 : Void*)
  alias JqMsgCb = (Void*, Jv -> Void)
  fun jq_get_error_cb(x0 : JqState, x1 : JqMsgCb*, x2 : Void**)
  fun jq_set_nomem_handler(x0 : JqState, x1 : (Void* -> Void), x2 : Void*)
  fun jq_format_error(msg : Jv) : Jv
  fun jq_report_error(x0 : JqState, x1 : Jv)
  fun jq_compile(x0 : JqState, x1 : LibC::Char*) : LibC::Int
  fun jq_compile_args(x0 : JqState, x1 : LibC::Char*, x2 : Jv) : LibC::Int
  fun jq_dump_disassembly(x0 : JqState, x1 : LibC::Int)
  fun jq_start(x0 : JqState, value : Jv, x2 : LibC::Int)
  fun jq_next(x0 : JqState) : Jv
  fun jq_teardown(x0 : JqState*)
  fun jq_halt(x0 : JqState, x1 : Jv, x2 : Jv)
  fun jq_halted(x0 : JqState) : LibC::Int
  fun jq_get_exit_code(x0 : JqState) : Jv
  fun jq_get_error_message(x0 : JqState) : Jv
  fun jq_set_input_cb(x0 : JqState, x1 : JqInputCb, x2 : Void*)
  alias JqInputCb = (JqState, Void* -> Jv)
  fun jq_get_input_cb(x0 : JqState, x1 : JqInputCb*, x2 : Void**)
  fun jq_set_debug_cb(x0 : JqState, x1 : JqMsgCb, x2 : Void*)
  fun jq_get_debug_cb(x0 : JqState, x1 : JqMsgCb*, x2 : Void**)
  fun jq_set_attrs(x0 : JqState, x1 : Jv)
  fun jq_get_attrs(x0 : JqState) : Jv
  fun jq_get_jq_origin(x0 : JqState) : Jv
  fun jq_get_prog_origin(x0 : JqState) : Jv
  fun jq_get_lib_dirs(x0 : JqState) : Jv
  fun jq_set_attr(x0 : JqState, x1 : Jv, x2 : Jv)
  fun jq_get_attr(x0 : JqState, x1 : Jv) : Jv
#  alias JqUtilInputState = Void
  fun jq_util_input_init(x0 : JqUtilMsgCb, x1 : Void*) : JqUtilInputState
  alias JqUtilMsgCb = (Void*, LibC::Char* -> Void)
  type JqUtilInputState = Void*
  fun jq_util_input_set_parser(x0 : JqUtilInputState, x1 : JvParser, x2 : LibC::Int)
  fun jq_util_input_free(x0 : JqUtilInputState*)
  fun jq_util_input_add_input(x0 : JqUtilInputState, x1 : LibC::Char*)
  fun jq_util_input_errors(x0 : JqUtilInputState) : LibC::Int
  fun jq_util_input_next_input(x0 : JqUtilInputState) : Jv
  fun jq_util_input_next_input_cb(x0 : JqState, x1 : Void*) : Jv
  fun jq_util_input_get_position(x0 : JqState) : Jv
  fun jq_util_input_get_current_filename(x0 : JqState) : Jv
  fun jq_util_input_get_current_line(x0 : JqState) : Jv
  fun jq_set_colors(x0 : LibC::Char*) : LibC::Int
end

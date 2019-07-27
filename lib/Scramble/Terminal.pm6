unit module Scramble::Terminal;

my module FFI {
    use NativeCall;

    my constant L = ‘BearLibTerminal’;

    class dimensions_t is repr(‘CStruct’)
    {
        has int32 $.width;
        has int32 $.height;
    }

    our sub terminal_close() is native(L) {*}
    our sub terminal_open(--> int32) is native(L) {*}
    our sub terminal_print(int32, int32, Str:D --> dimensions_t) is native(L) {*}
    our sub terminal_read(--> int32) is native(L) {*}
    our sub terminal_refresh() is native(L) {*}
}

our sub open(--> Nil)
{
    FFI::terminal_open() or die;
}

our sub close(--> Nil)
{
    FFI::terminal_close();
}

our sub refresh(--> Nil)
{
    FFI::terminal_refresh();
}

unit module Scramble::Terminal;

my module FFI {
    use NativeCall;

    my constant L = ‘BearLibTerminal’;

    our constant TK_ALIGN_DEFAULT = 0;

    our sub terminal_close() is native(L) {*}
    our sub terminal_open(--> int32) is native(L) {*}
    our sub terminal_print_ext8(int32, int32, int32, int32, int32, Str:D, int32 is rw, int32 is rw) is native(L) {*}
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

our sub print(Int:D $x, Int:D $y, Str:D $s --> Nil)
{
    my int32 $out-w;
    my int32 $out-h;
    FFI::terminal_print_ext8(
        $x, $y,
        0, 0,
        FFI::TK_ALIGN_DEFAULT,
        $s,
        $out-w, $out-h,
    );
}

our sub refresh(--> Nil)
{
    FFI::terminal_refresh();
}

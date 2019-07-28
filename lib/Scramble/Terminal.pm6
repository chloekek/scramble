unit module Scramble::Terminal;

my module FFI {
    use NativeCall;

    my constant L = ‘BearLibTerminal’;

    our constant TK_ALIGN_DEFAULT = 0;

    our sub terminal_bkcolor(uint32) is native(L) {*}
    our sub terminal_close() is native(L) {*}
    our sub terminal_color(uint32) is native(L) {*}
    our sub terminal_open(--> int32) is native(L) {*}
    our sub terminal_print_ext8(int32, int32, int32, int32, int32, Str:D, int32 is rw, int32 is rw) is native(L) {*}
    our sub terminal_read(--> int32) is native(L) {*}
    our sub terminal_refresh() is native(L) {*}
}

our constant TK_A = 0x04;
our constant TK_D = 0x07;
our constant TK_S = 0x16;
our constant TK_W = 0x1a;

our constant TK_CLOSE = 0xe0;

our sub open(--> Nil)
{
    FFI::terminal_open() or die;
}

our sub close(--> Nil)
{
    FFI::terminal_close();
}

our sub foreground-color(Int:D $c --> Nil)
{
    FFI::terminal_color($c);
}

our sub background-color(Int:D $c --> Nil)
{
    FFI::terminal_bkcolor($c);
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

our sub read(--> Int:D)
{
    FFI::terminal_read;
}

our sub refresh(--> Nil)
{
    FFI::terminal_refresh();
}

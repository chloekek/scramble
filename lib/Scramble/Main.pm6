unit module Main;

use Scramble::Terminal;

sub MAIN(--> Nil)
    is export
{
    Scramble::Terminal::open();
    Scramble::Terminal::refresh();
    sleep(5);
    Scramble::Terminal::close();
}

unit module Main;

use Scramble::Terminal;

sub MAIN(--> Nil)
    is export
{
    Scramble::Terminal::open();
    Scramble::Terminal::print(0, 3, "Hello, world!");
    Scramble::Terminal::refresh();
    sleep(5);
    Scramble::Terminal::close();
}

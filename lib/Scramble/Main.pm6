unit module Main;

use Noise::Simplex;
use Scramble::Region;
use Scramble::Terminal;
use Scramble::Tiles;

sub MAIN(--> Nil)
    is export
{
    Scramble::Terminal::open();

    my uint16 @tiles[16; 16];
    for ^16 X ^16 -> ($x, $y) {
        my $n := (1 + simplex-noise($x.Num / 10, $y.Num / 10)) / 2;
        @tiles[$x; $y] = (3 * $n).Int;
    }

    my $region := Scramble::Region.new(:@tiles);
    $region.render(0, 4);
    Scramble::Terminal::refresh();

    sleep(60);

    Scramble::Terminal::close();
}

unit module Main;

use Noise::Simplex;
use Scramble::Region;
use Scramble::Terminal;
use Scramble::Tiles;

sub MAIN(--> Nil)
    is export
{
    Scramble::Terminal::open();

    for ^6 X ^2 -> ($rx, $ry) {
        my uint16 @tiles[16; 16];
        for ^16 X ^16 -> ($tx, $ty) {
            my $n := (1 + simplex-noise(($rx * 16 + $tx).Num / 10,
                                        ($rx * 16 + $ty).Num / 10)) / 2;
            @tiles[$tx; $ty] = (4 * $n).Int;
        }

        my $region := Scramble::Region.new(:@tiles);
        $region.render($rx * 16, 4 + $ry * 16);
    }

    Scramble::Terminal::refresh();

    sleep(60);

    Scramble::Terminal::close();
}

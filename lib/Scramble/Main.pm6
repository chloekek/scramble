unit module Main;

use Noise::Simplex;
use Scramble::Region;
use Scramble::Terminal;
use Scramble::Tiles;
use Scramble::Vector;

sub MAIN(--> Nil)
    is export
{
    Scramble::Terminal::open();

    for ^6 X ^2 -> ($rx, $ry) {
        my uint16 @tiles[16; 16];
        for ^16 X ^16 -> ($tx, $ty) {
            my $n := (1 + simplex-noise(($rx * 16 + $tx).Num / 60,
                                        ($ry * 16 + $ty).Num / 60)) / 2;
            @tiles[$tx; $ty] = (6 * $n).Int;
        }

        my $region := Scramble::Region.new(:@tiles);
        my $vp := 16 ~* Scramble::Vector.new($rx, $ry);
        $region.render($vp);
    }

    Scramble::Terminal::refresh();

    sleep(60);

    Scramble::Terminal::close();
}

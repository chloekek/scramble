unit class Scramble::Region;

use Scramble::Terminal;
use Scramble::Tiles;

has uint16 @.tiles[16; 16];

method render(Int:D $x, Int:D $y --> Nil)
{
    for ^16 X ^16 -> ($tx, $ty) {
        my $t := tile-info(@!tiles[$tx; $ty]);
        $t.render($x + $tx, $y + $ty);
    }
}

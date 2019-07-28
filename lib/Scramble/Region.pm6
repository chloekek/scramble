unit class Scramble::Region;

use Scramble::Terminal;
use Scramble::Tiles;
use Scramble::Vector;

has uint16 @.tiles[16; 16];

method render(::?CLASS:D: Scramble::Vector:D $vp --> Nil)
{
    my $mvp := $vp;
    for ^16 X ^16 -> ($tx, $ty) {
        my $tile-vp := $mvp ~+ Scramble::Vector.new($tx, $ty);
        my $t := tile-info(@!tiles[$tx; $ty]);
        $t.render($tile-vp);
    }
}

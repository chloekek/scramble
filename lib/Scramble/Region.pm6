unit class Scramble::Region;

use Scramble::Terminal;

has uint16 @.tiles[16; 16];

method render(Int:D $x, Int:D $y --> Nil)
{
    for ^16 X ^16 -> ($tx, $ty) {
        my $t := @!tiles[$tx; $ty];
        my @s := ‘ ’, |<' ` . - : " $ # @>;
        Scramble::Terminal::print($x + $tx, $y + $ty, @s[$t]);
    }
}

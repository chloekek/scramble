unit module Main;

use Noise::Simplex;
use Scramble::Entity::PlayerCharacter;
use Scramble::Map;
use Scramble::Region;
use Scramble::Terminal;
use Scramble::Tiles;
use Scramble::Vector;

sub MAIN(--> Nil)
    is export
{
    Scramble::Terminal::open();

    my $map := Scramble::Map.new;

    for ^6 X ^2 -> ($rx, $ry) {
        my uint16 @tiles[16; 16];
        for ^16 X ^16 -> ($tx, $ty) {
            my $n := (1 + simplex-noise(($rx * 16 + $tx).Num / 60,
                                        ($ry * 16 + $ty).Num / 60)) / 2;
            @tiles[$tx; $ty] = (6 * $n).Int;
        }

        my $region := Scramble::Region.new(:@tiles);
        my $region-position := Scramble::Vector.new($rx, $ry);
        $map.regions{$region-position} = $region;
    }

    my $player-position := Scramble::Vector.new(30, 20);
    my $pc := Scramble::Entity::PlayerCharacter.new(position => $player-position);

    loop {
        my $vp := Scramble::Vector.new(0, 0);
        $map.render($vp);
        $pc.render($vp);

        Scramble::Terminal::refresh();

        given Scramble::Terminal::read() {
            when Scramble::Terminal::TK_W { $pc.position += Scramble::Vector.new( 0, -1) }
            when Scramble::Terminal::TK_S { $pc.position += Scramble::Vector.new( 0, +1) }
            when Scramble::Terminal::TK_A { $pc.position += Scramble::Vector.new(-1,  0) }
            when Scramble::Terminal::TK_D { $pc.position += Scramble::Vector.new(+1,  0) }
            when Scramble::Terminal::TK_CLOSE { last }
        }
    }

    Scramble::Terminal::close();
}

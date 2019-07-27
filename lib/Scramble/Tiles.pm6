unit module Scramble::Tiles;

use Scramble::Tile;

my class Scramble::Tile::Simple
    is Scramble::Tile
{
    has Str $.character is required;

    method render(::?CLASS:D: Int:D $dx, Int:D $dy --> Nil)
    {
        Scramble::Terminal::print($dx, $dy, $.character);
    }
}

my Scramble::Tile:D @tiles;

our constant DIRT = 0;
@tiles[DIRT] = Scramble::Tile::Simple.new(character => ‘.’);

our constant GRASS = 1;
@tiles[GRASS] = Scramble::Tile::Simple.new(character => ‘`’);

our constant MOSSY-GRASS = 2;
@tiles[MOSSY-GRASS] = Scramble::Tile::Simple.new(character => ‘:’);

sub tile-info(Int:D $id --> Scramble::Tile:D)
    is export
{
    @tiles[$id] // die;
}

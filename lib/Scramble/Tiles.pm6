unit module Scramble::Tiles;

use Scramble::Tile;

my class Scramble::Tile::Simple
    is Scramble::Tile
{
    has Str $.character is required;
    has Int $.foreground-color is required;
    has Int $.background-color is required;

    method render(::?CLASS:D: Int:D $dx, Int:D $dy --> Nil)
    {
        Scramble::Terminal::foreground-color($.foreground-color);
        Scramble::Terminal::background-color($.background-color);
        Scramble::Terminal::print($dx, $dy, $.character);
    }
}

my Scramble::Tile:D @tiles;

our constant DIRT = 0;
@tiles[DIRT] = Scramble::Tile::Simple.new(
    character => ‘.’,
    foreground-color => 0xffb37657,
    background-color => 0xff9b7653,
);

our constant GRASS = 1;
@tiles[GRASS] = Scramble::Tile::Simple.new(
    character => ‘`’,
    foreground-color => 0xff79944B,
    background-color => 0xff567D46,
);

our constant MOSSY-GRASS = 2;
@tiles[MOSSY-GRASS] = Scramble::Tile::Simple.new(
    character => ‘:’,
    foreground-color => 0xffb0ae5f,
    background-color => 0xff8a9a5b,
);

our constant ROCK = 3;
@tiles[ROCK] = Scramble::Tile::Simple.new(
    character => ‘%’,
    foreground-color => 0xff8e9b9e,
    background-color => 0xff808487,
);

sub tile-info(Int:D $id --> Scramble::Tile:D)
    is export
{
    @tiles[$id] // die;
}

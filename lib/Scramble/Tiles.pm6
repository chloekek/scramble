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

our constant WATER = 0;
@tiles[WATER] = Scramble::Tile::Simple.new(
    character => ‘~’,
    foreground-color => 0xff246291,
    background-color => 0xff224187,
);

our constant DIRT = 1;
@tiles[DIRT] = Scramble::Tile::Simple.new(
    character => ‘.’,
    foreground-color => 0xffb37657,
    background-color => 0xff9b7653,
);

our constant GRASS = 2;
@tiles[GRASS] = Scramble::Tile::Simple.new(
    character => ‘`’,
    foreground-color => 0xff79944B,
    background-color => 0xff567D46,
);

our constant MOSSY-GRASS = 3;
@tiles[MOSSY-GRASS] = Scramble::Tile::Simple.new(
    character => ‘:’,
    foreground-color => 0xffb0ae5f,
    background-color => 0xff8a9a5b,
);

our constant ROCK = 4;
@tiles[ROCK] = Scramble::Tile::Simple.new(
    character => ‘%’,
    foreground-color => 0xff8e9b9e,
    background-color => 0xff808487,
);

our constant SNOW = 5;
@tiles[SNOW] = Scramble::Tile::Simple.new(
    character => ‘,’,
    foreground-color => 0xffe8d1dc,
    background-color => 0xfffffafa,
);

sub tile-info(Int:D $id --> Scramble::Tile:D)
    is export
{
    @tiles[$id] // die;
}

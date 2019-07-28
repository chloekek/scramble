unit module Scramble::Tiles;

use Scramble::Tile;
use Scramble::Vector;

my class Scramble::Tile::Simple
    is Scramble::Tile
{
    has Str $.character is required;
    has Int $.foreground-color is required;
    has Int $.background-color is required;

    method render(::?CLASS:D: Scramble::Vector:D $vp --> Nil)
    {
        my $mvp := $vp;
        Scramble::Terminal::foreground-color($.foreground-color);
        Scramble::Terminal::background-color($.background-color);
        Scramble::Terminal::print($mvp.x, $mvp.y, $.character);
    }
}

my Scramble::Tile:D @tiles;

our constant WATER = 0;
@tiles[WATER] = Scramble::Tile::Simple.new(
    character => ‘~’,
    foreground-color => 0xff246291,
    background-color => 0xff224187,
);

our constant SAND = 1;
@tiles[SAND] = Scramble::Tile::Simple.new(
    character => ‘.’,
    foreground-color => 0xffd9bb84,
    background-color => 0xffc2b280,
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

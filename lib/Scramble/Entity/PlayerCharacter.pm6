unit class Scramble::Entity::PlayerCharacter;

use Scramble::Entity;
use Scramble::Vector;
use Scramble::Terminal;

also does Scramble::Entity;

method render-locally(::?CLASS:D: Scramble::Vector:D $mvp --> Nil)
{
    Scramble::Terminal::foreground-color(0xffffffff);
    Scramble::Terminal::background-color(0xff000000);
    Scramble::Terminal::print($mvp.x, $mvp.y, ‘@’);
}

unit role Scramble::Entity;

use Scramble::Vector;

has Scramble::Vector $.position is required is rw;

method render(::?CLASS:D: Scramble::Vector:D $vp --> Nil)
{
    self.render-locally($vp + $!position);
}

method render-locally(::?CLASS:D: Scramble::Vector:D $mvp --> Nil) {…}

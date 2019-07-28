class Scramble::Vector
{
    has int $.x;
    has int $.y;

    method new(Int:D $x, Int:D $y --> ::?CLASS:D)
    {
        self.bless(:$x, :$y);
    }
}

multi infix:«+»(Scramble::Vector:D $a, Scramble::Vector:D $b --> Scramble::Vector:D)
    is export
{
    Scramble::Vector.new($a.x + $b.x, $a.y + $b.y);
}

multi infix:«*»(Int:D $a, Scramble::Vector:D $b --> Scramble::Vector:D)
    is export
{
    Scramble::Vector.new($a * $b.x, $a * $b.y);
}

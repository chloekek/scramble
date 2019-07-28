unit class Scramble::Map;

use Scramble::Region;
use Scramble::Vector;

#| Regions indexed by region coordinates. Region coordinates must be
#| multiplied by the region size to obtain world coordinates.
has Scramble::Region:D %.regions{Scramble::Vector:D};

method render(::?CLASS:D: Scramble::Vector:D $vp --> Nil)
{
    for %!regions.kv -> $region-position, $region {
        my $region-vp := $vp + 16 * $region-position;
        $region.render($region-vp);
    }
}

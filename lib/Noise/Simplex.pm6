unit module Noise::Simplex;

#`｢
Adapted from github/SRombauts/SimplexNoise. License of the original C++ code:

The MIT License (MIT)

Copyright (c) 2012-2018 Sebastien Rombauts (sebastien.rombauts@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
｣

sub simplex-noise(Num:D $x, Num:D $y --> Num:D)
    is export
{
    my num $n0;  # Noise contributions from the three corners
    my num $n1;
    my num $n2;

    # Skewing/Unskewing factors for 2D
    my constant F2 = (sqrt(3e0) - 1e0) / 2e0;
    my constant G2 = (3e0 - sqrt(3e0)) / 6e0;

    # Skew the input space to determine which simplex cell we're in
    my num $s = ($x + $y) * F2;  # Hairy factor for 2D
    my num $xs = $x + $s;
    my num $ys = $y + $s;
    my int32 $i = fastfloor($xs);
    my int32 $j = fastfloor($ys);

    # Unskew the cell origin back to (x,y) space
    my num $t = ($i + $j) * G2;
    my num $X0 = $i - $t;
    my num $Y0 = $j - $t;
    my num $x0 = $x - $X0;  # The x,y distances from the cell origin
    my num $y0 = $y - $Y0;

    # For the 2D case, the simplex shape is an equilateral triangle.
    # Determine which simplex we are in.
    my int32 $i1;  # Offsets for second (middle) corner of simplex in (i,j) coords
    my int32 $j1;
    if $x0 > $y0 {   # lower triangle, XY order: (0,0)->(1,0)->(1,1)
        $i1 = 1;
        $j1 = 0;
    } else {   # upper triangle, YX order: (0,0)->(0,1)->(1,1)
        $i1 = 0;
        $j1 = 1;
    }

    # A step of (1,0) in (i,j) means a step of (1-c,-c) in (x,y), and
    # a step of (0,1) in (i,j) means a step of (-c,1-c) in (x,y), where
    # c = (3-sqrt(3))/6

    my num $x1 = $x0 - $i1 + G2;        # Offsets for middle corner in (x,y) unskewed coords
    my num $y1 = $y0 - $j1 + G2;
    my num $x2 = $x0 - 1e0 + 2e0 * G2;  # Offsets for last corner in (x,y) unskewed coords
    my num $y2 = $y0 - 1e0 + 2e0 * G2;

    # Work out the hashed gradient indices of the three simplex corners
    my int $gi0 = hash($i + hash($j));
    my int $gi1 = hash($i + $i1 + hash($j + $j1));
    my int $gi2 = hash($i + 1 + hash($j + 1));

    # Calculate the contribution from the first corner
    my num $t0 = 0.5e0 - $x0*$x0 - $y0*$y0;
    if $t0 < 0e0 {
        $n0 = 0e0;
    } else {
        $t0 *= $t0;
        $n0 = $t0 * $t0 * grad($gi0, $x0, $y0);
    }

    # Calculate the contribution from the second corner
    my num $t1 = 0.5e0 - $x1*$x1 - $y1*$y1;
    if $t1 < 0e0 {
        $n1 = 0e0;
    } else {
        $t1 *= $t1;
        $n1 = $t1 * $t1 * grad($gi1, $x1, $y1);
    }

    # Calculate the contribution from the third corner
    my num $t2 = 0.5e0 - $x2*$x2 - $y2*$y2;
    if $t2 < 0e0 {
        $n2 = 0e0;
    } else {
        $t2 *= $t2;
        $n2 = $t2 * $t2 * grad($gi2, $x2, $y2);
    }

    # Add contributions from each corner to get the final noise value.
    # The result is scaled to return values in the interval [-1,1].
    return 45.23065e0 * ($n0 + $n1 + $n2);
}

sub fastfloor(Num:D $fp --> Int:D)
{
    my int32 $i = $fp.Int;
    return $fp < $i ?? $i - 1 !! $i;
}

sub grad(Int:D $hash, Num:D $x, Num:D $y --> Num:D)
{
    my int32 $h = $hash +& 0x3F;     # Convert low 3 bits of hash code
    my num $u = $h < 4 ?? $x !! $y;  # into 8 simple gradient directions,
    my num $v = $h < 4 ?? $y !! $x;

    # and compute the dot product with (x,y).
    return (($h +& 1) ?? -$u !! $u) + (($h +& 2) ?? -2e0 * $v !! 2e0 * $v);
}

sub hash(Int:D $i --> Int:D)
{
    my constant @perm = [
        151, 160, 137, 91, 90, 15, 131, 13, 201, 95, 96, 53, 194, 233, 7,
        225, 140, 36, 103, 30, 69, 142, 8, 99, 37, 240, 21, 10, 23, 190, 6,
        148, 247, 120, 234, 75, 0, 26, 197, 62, 94, 252, 219, 203, 117, 35,
        11, 32, 57, 177, 33, 88, 237, 149, 56, 87, 174, 20, 125, 136, 171,
        168, 68, 175, 74, 165, 71, 134, 139, 48, 27, 166, 77, 146, 158, 231,
        83, 111, 229, 122, 60, 211, 133, 230, 220, 105, 92, 41, 55, 46, 245,
        40, 244, 102, 143, 54, 65, 25, 63, 161, 1, 216, 80, 73, 209, 76, 132,
        187, 208, 89, 18, 169, 200, 196, 135, 130, 116, 188, 159, 86, 164,
        100, 109, 198, 173, 186, 3, 64, 52, 217, 226, 250, 124, 123, 5, 202,
        38, 147, 118, 126, 255, 82, 85, 212, 207, 206, 59, 227, 47, 16, 58,
        17, 182, 189, 28, 42, 223, 183, 170, 213, 119, 248, 152, 2, 44, 154,
        163, 70, 221, 153, 101, 155, 167, 43, 172, 9, 129, 22, 39, 253, 19,
        98, 108, 110, 79, 113, 224, 232, 178, 185, 112, 104, 218, 246, 97,
        228, 251, 34, 242, 193, 238, 210, 144, 12, 191, 179, 162, 241, 81,
        51, 145, 235, 249, 14, 239, 107, 49, 192, 214, 31, 181, 199, 106,
        157, 184, 84, 204, 176, 115, 121, 50, 45, 127, 4, 150, 254, 138, 236,
        205, 93, 222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66, 215,
        61, 156, 180,
    ];
    return @perm[$i % 256];
}

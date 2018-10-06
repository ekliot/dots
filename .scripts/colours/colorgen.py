from PIL import Image
import colorsys
import math
import heapq
import sys

def main():
    img = sys.argv[1]

    colors = get_term_colors( img )

    for c in range( len( colors ) ):
        print( xresources_vars[c] + colors[c] )


def isolate_colors( filename, ncolors ):
    img = Image.open( filename )

    if img.mode != 'RGB':
        img = img.convert( 'RGB' )

    img = img.convert( 'P', palette=Image.ADAPTIVE, colors=ncolors )
    img = img.convert( 'RGB' )

    return sorted( img.getcolors( ncolors ), reverse=True )

def dedupe( count_color, rollup=10 ):
    result = {}

    for count, rgb in count_color:

        if rgb in result:
            result[rgb] += count

        else:
            for rrgb in result:
                dist = euclidean_dist( rrgb, rgb )

                if dist < rollup:
                    result[rrgb] += count
                    break

            else:
                result[rgb] = count

    return sorted( [ ( count, color ) for color, count in result.items() ],
                   reverse=True )

def euclidean_dist( p1, p2 ):
    return math.sqrt( sum( ( p1[i] - p2[i] ) ** 2 for i in range( 3 ) ) )

def get_xcolors( colors, substitution_distance=20 ):
    results = []

    for crgb in canonical: # self.canonical:

        distances = []

        for rgb in colors:
            distance = euclidean_dist( crgb, rgb[1] )
            heapq.heappush( distances, ( distance, rgb ) )

        # First, try the closest RGB match.
        best = heapq.nsmallest( 1, distances )[0][1]

        if best not in results:
            results.append( best )

        else:
            # Attempt to find a substitute.
            current = 0  # Distance from best color to potential substitute.
            min_dist = None
            vals = []

            while distances and current < substitution_distance:
                dist, rgb = heapq.heappop( distances )
                vals.append( rgb )

                # Here we're keeping an eye on the distance between
                # the potential substitute color, and the original
                # "best" color.
                if min_dist is None:
                    min_dist = dist
                else:
                    current = dist - min_dist

            for rgb in vals:
                if rgb not in results:
                    # We found a substitute that isn't in use.
                    results.append( rgb )
                    break

            else:
                # No substitute found, just use the best match.
                results.append( vals[0] )

    return results

def ensure_value( rgb, low, high ):
    r, g, b = rgb
    h, s, v = colorsys.rgb_to_hsv( r / 256., g / 256., b / 256. )
    v = max( min( v, high ), low )

    return tuple( [ i * 256. for i in colorsys.hsv_to_rgb( h, s, v ) ] )


def rgb_to_hex( rgb ):
    return ( '#%02x%02x%02x' % rgb )

def get_term_colors( filename ):
    img_colors  = isolate_colors( filename, 64 )
    trim_colors = dedupe( img_colors )
    term_colors = get_xcolors( trim_colors )

    results = []

    for count, color in term_colors:
        results.append( rgb_to_hex( color ) )

    return results

canonical = [
    (0, 0, 0),  # Black
    (255, 0, 0),  # Red
    (0, 255, 0),  # Green
    (255, 255, 0),  # Yellow
    (0, 0, 255),  # Blue
    (255, 0, 255), # Magenta
    (0, 255, 255),  # Cyan
    (192, 192, 192),  # Light gray

    (64, 64, 64),  # Dark gray
    (255, 0, 0),  # Red
    (0, 255, 0),  # Green
    (255, 255, 0),  # Yellow
    (0, 0, 255),  # Blue
    (255, 0, 255), # Magenta
    (0, 255, 255),  # Cyan
    (255, 255, 255),  # White
]

xresources_vars = [
    "*color0:         ",
    "*color1:         ",
    "*color2:         ",
    "*color3:         ",
    "*color4:         ",
    "*color5:         ",
    "*color6:         ",
    "*color7:         ",

    "*color8:         ",
    "*color9:         ",
    "*color10:        ",
    "*color11:        ",
    "*color12:        ",
    "*color13:        ",
    "*color14:        ",
    "*color15:        ",
]

main()

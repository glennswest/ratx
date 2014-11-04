// Grid
// By Dana Woodman <dana@danawoodman.com>


// Settings
//--------------------------
module grid(width=30,height=30,cols=10,rows=10,border=4,spacing=.8)
{


// The magic...
//--------------------------

// Calculated inner width of dispaly area.
innerWidth = (width - (2 * border));
innerHeight = (height - (2 * border));
//echo("innerWidth", innerWidth, "innerHeight", innerHeight);

// Calculate size of the squares.
function dimension(size, divisions) = (size - ((divisions - 1) * spacing)) / divisions;
xWidth = dimension(innerWidth, cols);
yWidth = dimension(innerHeight, rows);
//echo("xWidth", xWidth, "yWidth", yWidth);

function calculate_location(size, index, spacing) = (size + spacing) * index;

// Subtract the squares from the display area.
difference() {

	// The display area.
	square([width, height]);

	// Offset by border size.
	translate([border, border])

		// Iterate over all the columns.
		for (col = [0 : cols - 1]) {
			
			// Iterate over all the rows.
			for (row = [0 : rows - 1]) {

				// Caclulate position of each square
				translate([
					calculate_location(xWidth, col, spacing), 
					calculate_location(yWidth, row, spacing)
				])
					square([xWidth, yWidth]);
			}
		}
 }
}

grid();
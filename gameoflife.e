class
	GAMEOFLIFE

inherit
	ARGUMENTS_32


create
	make

--Class Attributes

feature
	grid : ARRAY2[EUKARYOTICCELLS]
	cell : EUKARYOTICCELLS

feature {NONE} -- Initialization
	make
		-- Run application.
		local
			i : INTEGER
			j : INTEGER
			y : INTEGER
		do
			create cell.make(1, 1, argument_array.item(3).to_double) --Dummy cell to create grid
			create grid.make_filled (cell, argument_array.item (1).to_integer, argument_array.item (2).to_integer)

			from
				i := 1
			until
				i > argument_array.item (1).to_integer
			loop
				from
					j := 1
				until
					j > argument_array.item (2).to_integer
				loop
					create cell.make (i, j, argument_array.item(3).to_double)
					grid.item (i, j) := cell
					j := j + 1
				end
				i := i + 1
			end

			across grid as l
			loop
				l.item.neighbours (grid) --loops across the whole grid to set up the neighbours for the first evolution.
			end

			from
				y := 1
			until
				y > 20
			loop
				update
				io.new_line
				draw
				y := y + 1
			end


		end

--Feature to update every cell's alive variable in the grid for the next evolution.
--i : INTEGER is used in the loop to count up.
--j : INTEGER is used in the loop to count up.
--No result.

feature
	update
		local
			i : INTEGER
			j : INTEGER

		do
			from
				i := grid.lower
			until
				i > argument_array.item (1).to_integer
			loop
				from
					j := grid.lower
				until
					j > argument_array.item (2).to_integer
				loop
					grid.item (i, j).next
					grid.item (i, j).neighbours (grid)
					j := j + 1
				end
				i := i + 1
			end

			across grid as l
			loop
				l.item.updateAlive --loops across the whole grid to set up the neighbours for the first evolution.
			end
		end

--Feature to draw the grid on the console.
--# is alive == true, - is alive == false
--Attributes of the feature:
--i : INTEGER is used in the loop to count up.
--j : INTEGER is used in the loop to count up.
--No result.

feature

	draw
		local
			i : INTEGER
			j : INTEGER
		do
			from
				i := grid.lower
			until
				i > argument_array.item (1).to_integer
			loop
				from
					j := grid.lower
				until
					j > argument_array.item (2).to_integer
				loop
					if
						grid.item (i, j).alive
					then
						io.put_string ("#")
					else
						io.put_string ("-")
					end
					j := j + 1
				end
				io.new_line
				i := i + 1
			end
		end

end

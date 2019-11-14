note
	description: "Summary description for {EUKARYOTICCELLS}."
	author: "Phillipp Lohmann, Kris Viehl, Patrick Keppeler, Mohammed Kalash, Dennis Zeller"
	date: "07.11.19"

class
	EUKARYOTICCELLS

inherit
	ARGUMENTS_32

create
	make

-- Class Attributes:
-- x : INTEGER is the x coordinate.
-- y : INTEGER is the y coordinate.
-- alive : BOOLEAN is the current living state of the cell.
-- aliveTemp : BOOLEAN saves the living state of the cell for the next generation.
-- neighboursArrayed : ARRAYED_LIST[EUKARYOTICCELLS] includes the neighbours of the cell.

feature
			x : INTEGER
			y : INTEGER
			alive : BOOLEAN
			aliveTemp : BOOLEAN
			neighboursArrayed : ARRAYED_LIST[EUKARYOTICCELLS]

-- Constructor

feature {NONE} -- Initialization
	make(x1 : INTEGER; y1 : INTEGER; probability : DOUBLE)
			-- Run application.
		local
			random : DOUBLE
		do
			x := x1
			y := y1
			aliveTemp := alive
			random := randomValue(x, y)
			if
				random <= probability -- The generated random value is a double between 0..1 and compared to the given probability.
									  -- If random is <= the cell is alive.
			then
				alive := true
			else
				alive := false
			end
			create neighboursArrayed.make (0)
		end

-- Feature to generate a random value.
-- i : INTEGER is used in the loop to count up.
-- random : RANDOM is the create random value.
-- size : INTEGER is used to get the unique value of the cell.
-- ((x * argument_array.item (1).to_integer) + y) - 4 because x = 1 | y = 2 and x = 2 | y = 1 would be the same if we just multiply.
-- -4 because Eiffel Arrays start at 1. This helps to reduce the amount of needed loops.
-- Loops from 1 to the index of the cell and get a new "random" number for each iteration.
-- Because the index of every cell is unique it can be used for the amount of iterations.

feature
	randomValue(x1 : INTEGER; y1 : INTEGER) : DOUBLE
		local
			i : INTEGER
			random : RANDOM
			size : INTEGER
		do
			create random.make
			random.start
			size := (((x1 * argument_array.item (1).to_integer) + y1) - 4)
			from
				i := 1
			until
				i > size
			loop
				random.forth
				i := i + 1
			end
			Result := random.double_item
		end

--Feature to set alive because set_item(boolean) doesn't work properlly.

feature
	setAliveTemp(bool : BOOLEAN)
		do
			aliveTemp := bool
		end

--Feature to update alive with the value of the aliveTemp

feature
	updateAlive
		do
			alive := aliveTemp
		end

--Feature to get amount of neighbours from the current cell.
--Attributes of the feature:
--low : INTEGER is the lowest possible index of the grid.
--highX : INTEGER is the highest possible index of the x axe.
--highY : INTEGER is the highest possible index of the y axe.
--No result.

feature
	neighbours(grid : ARRAY2[EUKARYOTICCELLS])

		local
			low : INTEGER
			highX : INTEGER
			highY : INTEGER
		do
			low := 1
			highX := argument_array.item (1).to_integer
			highY := argument_array.item (2).to_integer
			if
				Current.x /= low
			then
				neighboursArrayed.extend (grid.item (Current.x - 1, Current.y))
				--west direction
			end
			if
				Current.x /= highX
			then
				neighboursArrayed.extend (grid.item (Current.x + 1, Current.y))
				--east direction
			end
			if
				Current.x /= low and Current.y /= low
			then
				neighboursArrayed.extend (grid.item (Current.x - 1, Current.y - 1))
				--north-west direction
			end
			if
				Current.x /= low and Current.y /= highY
			then
				neighboursArrayed.extend (grid.item (Current.x - 1, Current.y + 1))
				--north east direction
			end
			if
				Current.x /= highX and Current.y /= low
			then
				neighboursArrayed.extend (grid.item (Current.x + 1, Current.y - 1))
				--south-west direction
			end
			if
				Current.x /= highX and Current.y /= highY
			then
				neighboursArrayed.extend (grid.item (Current.x + 1, Current.y + 1))
				--south-east direction
			end
			if
				Current.y /= low
			then
				neighboursArrayed.extend (grid.item (Current.x, Current.y -1))
				--north direction
			end
			if
				Current.y /= highY
			then
				neighboursArrayed.extend (grid.item (Current.x, Current.y + 1))
				--south direction
			end
		end

--Method to update the cell for the next evolution.
--Attributes of the feature:
--aliveN : INTEGER are the amount of living neighbours of the cell.
--i : INTEGER is used in the loop to count up.
--No result.

feature
	next
		local
			aliveN : INTEGER
			i : INTEGER
		do
			aliveN := 0

			from
				i := 1
			until
				i > neighboursArrayed.count
			loop
				if
					neighboursArrayed.at (i).alive
				then
					aliveN := aliveN + 1
				end
				i := i + 1
			end
			if
				Current.alive
			then
				if
					aliveN < 2
				then
					setAliveTemp(false)
				elseif
					aliveN > 3
				then
					setAliveTemp(false)
				elseif
					aliveN = 2 or aliveN = 3
				then
					setAliveTemp(true)
				end
			else
				if
					aliveN = 3
				then
					setAliveTemp(true)
				end
			end
		end
end



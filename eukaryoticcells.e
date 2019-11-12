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

--Class Attributes

feature
			x : INTEGER
			y : INTEGER
			alive : BOOLEAN
			aliveTemp : BOOLEAN
			neighboursArrayed : ARRAYED_LIST[EUKARYOTICCELLS]

feature {NONE} -- Initialization
	make(x1 : INTEGER; y1 : INTEGER; probability : DOUBLE)
			-- Run application.
		local
			random : RANDOM
			size : INTEGER
		do
			x := x1
			y := y1
			size := (x * y)
        	across
        		1 |..| size  as i
    		from
        		create random.set_seed (1)
        		random.start
    		loop
        		random.forth
    		end
			if
				random.double_item <= probability
			then
				alive := true
			else
				alive := false
			end
			aliveTemp := alive
			create neighboursArrayed.make (0)
		end

--Feature to set the coordinates from a existing cell
--No Result

feature
	setUpCell(x1 : INTEGER; y1 : INTEGER; alive1 : BOOLEAN)
--Lokale Random Varibale machen und mit der Übergebenen probability vergleichen, wenn der Random Wert kleiner als die probability ist, ist die Zelle alive.
--Boolean alive zu probability double ändern und boolean berechnen mit ^
		do
			x := x1
			y := y1
			alive := alive1
		end

--Feature to get amount of neighbours from the current cell.
--Attributes of the feature:
--low : INTEGER is the lowest possible index of the grid.
--highX : INTEGER is the highest possible index of the x axe.
--highY : INTEGER is the highest possible index of the y axe.
--No result

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

--Feature to set alive because set_item(boolean) does't work properlly.
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
end



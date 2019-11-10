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
			gridBool : ARRAY2[BOOLEAN]

feature {NONE} -- Initialization
	make(x1 : INTEGER; y1 : INTEGER; alive1 : BOOLEAN)
			-- Run application.
		do
			x := x1
			y := y1
			alive := alive1
			create gridBool.make_filled (false, argument_array.item (2).to_integer, argument_array.item (3).to_integer) --Create gridBool with default values.
		end

--Feature to set the coordinates from a existing cell
--No Result

feature
	setUpCell(x1 : INTEGER; y1 : INTEGER; alive1 : BOOLEAN)
--Lokale Random Varibale machen und mit der Übergebenen probability vergleichen, wenn der Random Wert kleiner als die probability ist, ist die Zelle alive.
--Boolean alive zu probability double ändern und boolean berechnen mit ^
--Update Feature schreiben um gridBool nach jeder Runde auf den neusten Stand zu bringen.
		do
			x := x1
			y := y1
			gridBool.item (x1, x1) := alive1
		end

--Feature to get amount of neighbours from the current cell.
--Attributes of the feature:
--low : INTEGER is the lowest possible index of the grid.
--highX : INTEGER is the highest possible index of the x axe.
--highY : INTEGER is the highest possible index of the y axe.
--Result is a ARRAYED_LIST of the type Eukaryoticcells which contains the cells neighbours.

feature
	neighbours : ARRAYED_LIST[BOOLEAN]

		local
			low : INTEGER
			highX : INTEGER
			highY : INTEGER
			temp : ARRAYED_LIST[BOOLEAN]
		do
			create temp.make (0)
			low := 1
			highX := argument_array.item (2).to_integer
			highY := argument_array.item (3).to_integer
			if
				Current.x /= low
			then
				temp.extend (gridBool.item (Current.x - 1, Current.y))
				--west direction
			end
			if
				Current.x /= highX
			then
				temp.extend (gridBool.item (Current.x + 1, Current.y))
				--east direction
			end
			if
				Current.x /= low and Current.y /= low
			then
				temp.extend (gridBool.item (Current.x - 1, Current.y - 1))
				--north-west direction
			end
			if
				Current.x /= highX and Current.y /= low
			then
				temp.extend (gridBool.item (Current.x - 1, Current.y + 1))
				--north east direction
			end
			if
				Current.x /= low and Current.y /= highY
			then
				temp.extend (gridBool.item (Current.x + 1, Current.y - 1))
				--south-west direction
			end
			if
				Current.x /= highX and Current.y /= low
			then
				temp.extend (gridBool.item (Current.x + 1, Current.y + 1))
				--south-east direction
			end
			if
				Current.y /= low
			then
				temp.extend (gridBool.item (Current.x, Current.y -1))
				--north direction
			end
			if
				Current.y /= highY
			then
				temp.extend (gridBool.item (Current.x, Current.y + 1))
				--south direction
			end
			Result := temp
		end

--Method to update the cell for the next evolution.
--Attributes of the feature:
--ARRAYED_LIST[EUKARYOTICCELLS] is a list of all neighbours.
--aliveN : INTEGER are the amount of living neighbours of the cell.
--deadN : INTEGER are the amount of dead neighbours of the cell.
--i : INTEGER is used in the loop to count up.
--No result.

feature
	next

		local
			neighboursCell : ARRAYED_LIST[BOOLEAN]
			aliveN : INTEGER
			deadN : INTEGER
			i : INTEGER
		do
			aliveN := 0
			deadN := 0
			neighboursCell := neighbours
			from
				i := 1
			until
				i > neighboursCell.count
			loop
				if
					neighboursCell.at (i)
				then
					aliveN := aliveN + 1
				else
					deadN := deadN + 1
				end
				i := i + 1
			end
			if
				Current.alive
			then
				if
					aliveN < 2
				then
					Current.alive.set_item (true)
				elseif
					aliveN > 3
				then
					Current.alive.set_item (false)
				elseif
					aliveN = 2 or aliveN = 3
				then
					Current.alive.set_item (true)
				end
			else
				if
					aliveN = 3
				then
					Current.alive.set_item (true)
				end
			end
		end
end

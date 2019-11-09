class
	EUKARYOTICCELLS

inherit
	ARGUMENTS_32

create
	make

--Konstruktor? Mit x,y passend zur Position im Grid von GameOfLife? Wo wird die Wahrscheinlichkeit von alive berechnet?

feature {NONE} -- Initialization
	make(x1 : INTEGER; y1 : INTEGER; alive1 : BOOLEAN)
			-- Run application.
		do
			create gol.make
		end

--Class Attributes

feature
			x : INTEGER
			y : INTEGER
			alive : BOOLEAN
			gol : GAMEOFLIFE

--Feature to set the coordinates from a existing cell
--No Result
--Richtig so? Hier fehlt noch die Wahrscheinlichkeits Berechnung in Verbindung mit der alive Variablen. Vielleicht besser im Konstruktor.
feature
	setUpCell(x1 : INTEGER; y1 : INTEGER)
		do
			x := x1
			y := y1

		end


--Feature to get amount of neighbours from the current cell.
--Attributes of the feature:
--INTEGER low is the lowest possible index of the grid.
--INTEGER highX is the highest possible index of the x axe.
--INTEGER highY is the highest possible index of the y axe.
--Result is a ARRAYED_LIST of the type Eukaryoticcells.

feature
	neighbours : ARRAYED_LIST[EUKARYOTICCELLS]

		local
			low : INTEGER
			highX : INTEGER
			highY : INTEGER
			temp : ARRAYED_LIST[EUKARYOTICCELLS]
		do
			create temp.make (0)
			low := 1
			highX := argument_array.item (2).to_integer
			highY := argument_array.item (3).to_integer
			if
				Current.x /= low
			then
				temp.extend (gol.grid.item (Current.x - 1, Current.y))
				--west direction
			end
			if
				Current.x /= highX
			then
				temp.extend (gol.grid.item (Current.x + 1, Current.y))
				--east direction
			end
			if
				Current.x /= low and Current.y /= low
			then
				temp.extend (gol.grid.item (Current.x - 1, Current.y - 1))
				--north-west direction
			end
			if
				Current.x /= highX and Current.y /= low
			then
				temp.extend (gol.grid.item (Current.x - 1, Current.y + 1))
				--north east direction
			end
			if
				Current.x /= low and Current.y /= highY
			then
				temp.extend (gol.grid.item (Current.x + 1, Current.y - 1))
				--south-west direction
			end
			if
				Current.x /= highX and Current.y /= low
			then
				temp.extend (gol.grid.item (Current.x + 1, Current.y + 1))
				--south-east direction
			end
			if
				Current.y /= low
			then
				temp.extend (gol.grid.item (Current.x, Current.y -1))
				--north direction
			end
			if
				Current.y /= highY
			then
				temp.extend (gol.grid.item (Current.x, Current.y + 1))
				--south direction
			end
			Result := temp
		end

--Method to update the cell for the next evolution.
--Attributes of the feature:
--ARRAYED_LIST[EUKARYOTICCELLS] is a list of all neighbours.
--INTEGER aliveN are the amount of living neighbours of the cell.
--INTEGER deadN are the amount of dead neighbours of the cell.
--INTEGER i is used in the loop to count up.
--No result.

feature
	next

		local
			neighboursCell : ARRAYED_LIST[EUKARYOTICCELLS]
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
					neighboursCell[i].alive
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

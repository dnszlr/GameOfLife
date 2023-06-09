note
	description: "Summary description for {APPLICATION}."
	author: "Phillipp Lohmann, Kris Viehl, Patrick Keppeler, Mohammed Kalash, Dennis Zeller"
	date: "07.11.19"

class
	APPLICATION

inherit
	EXECUTION_ENVIRONMENT

create
	make

feature
	gol : GAMEOFLIFE
	--argument_array(1) is the height of the grid (INTEGER)
	--argument_array(2) is the width of the grid (INTEGER)
	--argument_array(3) is the probability for the alive status of a cell, has to be between 0..1 (DOUBLE)

feature{NONE}
	make
		local
			i : INTEGER
		do
			create gol.make
			from --Fake loop for endless simulation.
				i := 1
			until
				i > 4
			loop
				gol.draw
				gol.update
				io.new_line
				sleep(3000000000) -- Sleep timer to slow down the simulation for better observation.
			end
		end

end

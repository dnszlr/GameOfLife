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

feature{NONE}
	make
		local
			i : INTEGER
		do
			create gol.make
			from --Fake loop for endless simulation.
				i := 1
			until
				i > 10
			loop
				gol.draw
				gol.update
				sleep(1000000000)
			end
		end

end

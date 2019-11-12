note
	description: "Summary description for {APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
				io.
			end
		end

end

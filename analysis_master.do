* downloading and installing gis libraries
ssc install project
ssc install spmap

* Common settings

set more off
set varabbrev off  // less confusing
set linesize 132   // use 7pt font for printing

* Run do-files
project, doinfo
local master "`r(pdir)'"
local doname "`r(dofile)'"
        
project, original("`master'/dtas/Advance Data Analysis - Socio Economic New.dta")
project, original("`master'/dtas/Advance Data Analysis - Infrastructure.dta")
project, original("`master'/dtas/bangdb.dta")
project, original("`master'/dtas/bangcoord.dta")
project , do(dos/analysis.do)

* loading project dta files
project, doinfo
local master "`r(pdir)'"
local doname "`r(dofile)'"

* dta load and merge
use "`master'/dtas/Advance Data Analysis - Socio Economic New.dta", clear
merge 1:1 Ward Name using "`master'/dtas/Advance Data Analysis - Infrastructure.dta"

* data cleaning
destring, replace
rename Ward WARD_NO
duplicates report WARD_NO
duplicates drop

* exploratory data analysis
browse
describe
summarize
correlate HHwithBanking HHwithAssets Percent_SC_ST_Pop Percent_ILL_Pop Workforce_Participation
correlate TapWater_Treated ConcreteWalls Electriclighting ClosedDrainage

* SED index generation
egen std_assets = std(HHwithAssets)
egen std_percent_sc_sc = std(Percent_SC_ST_Pop)
egen std_ill = std(Percent_ILL_Pop)
egen std_wp = std(Workforce_Participation)
summarize
generate sed = std_percent_sc_sc + std_ill - std_wp - std_assets
summarize sed
format sed %14.2f

* InfraD index generation
egen std_tap = std(TapWater_Treated)
egen std_walls = std(ConcreteWalls)
egen std_light = std(Electriclighting)
egen std_drain = std(ClosedDrainage)
summarize
generate infrad = - std_tap - std_walls - std_light - std_drain
summarize infrad
format infrad %14.2f

* load Bangalore gis db and merge with data
merge 1:1 WARD_NO using "`master'/dtas/bangdb.dta", nogenerate

* SED Choropleth map plot for BBMP Wards
spmap sed using "`master'/dtas/bangcoord.dta", id(id)	///
clmethod(custom) clnumber(5) clbreaks(-6 -3 0 3 6 9) fcolor(Reds) ///
title("Socio-Economic Index of BBMP Ward", size(*0.8))	///
subtitle("The wards with the index value above 6 are the most socio-economically deprived wards", size(*0.4))	///  
legstyle(1) legtitle("Index Value") legend(region(lcolor(black)) position(2))

* InfraD Choropleth map plot for BBMP Wards
spmap infrad using "`master'/dtas/bangcoord.dta", id(id)	///
clmethod(custom) clnumber(7) clbreaks(-5 -2.5 0 2.5 5 7.5 10 12.5) fcolor(Blues) ///
title("Quality of Infrastructure Index of BBMP Ward", size(*0.8))	///
subtitle("The wards with the index value above 5 are the wards with lowest quality of infrstructure", size(*0.4))	///  
legstyle(1) legtitle("Index Value") legend(region(lcolor(black)) position(2))

* scatterplot between SED and InfraD
scatter sed infrad

*The End





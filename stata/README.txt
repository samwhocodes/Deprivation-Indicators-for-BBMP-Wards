Run the following commands in Stata:

	ssc install project
	project, setup
 
Then navigate to analysis-master.do in the root folder. 
Decide whether you want plain-text or SMCL log files, then hit OK.

Finally run the following command to replicate the analysis:

	project analysis_master, replicate
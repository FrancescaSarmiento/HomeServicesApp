# HomeServicesApp
This is our repository for our Home Services Application on Web Systems and Technology Laboratory.

IMPORTANT (25/04/2017):
Please AVOID pushing to the 'master' branch, unless the current version is final and has low chance of being modified. Push your commits to the branch specified for your section instead (e.g. "Service Provider branch")

UPDATE (7/05/2017):
The SP schedule works by the following thingies:
	- the columns 'shift_start' and 'shift_end' are the time range an SP is available for the day (provided that he doesn't have a current job during his shift)*.
	- the 'working_days' column is a comma-separated-values column that represents the days an SP is available. The days are presented in its 'abbreviated' form (see row 0 in 'service_provider' table for the representations), and are separated by commas in case they're available in multiple days.
	
	ADDITIONAL NOTES:
	*This assumes that the shift period of an SP is the same througt his available days. I can't seem to find a way for a day-specific time shifts without making things complicated.
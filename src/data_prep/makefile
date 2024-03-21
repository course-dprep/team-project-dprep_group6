all: clean.R

clean: 
	r --e "unlink("*.csv")"
	r --e "unlink("*.csv.gz")"

clean.R: listings.csv calendar.csv.gz download.R
	R --vanilla < clean.R

listings.csv calendar.csv.gz:
	R --vanilla < download.R


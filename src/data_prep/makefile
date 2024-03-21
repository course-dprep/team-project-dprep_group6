all: clean.R

clean: 	rm -f "unlink("*.csv")"	
	rm -f "unlink("*.csv.gz")"

clean.R: listings.csv calendar.csv.gz download.R
	R --vanilla < clean.R

listings.csv calendar.csv.gz:
	R --vanilla < download.R


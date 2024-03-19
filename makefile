plot_all.pdf: run_antwerp.R aggregated_df.csv
	R --vanilla < run_antwerp.R
	
clean: 
	R -e "unlink('*.pfd')"
	R -e "unlink('*.csv')"
	
../temp/listings.csv reviews.csv:
	R --vanilla < download.R
	
aggregated_df.csv: reviews.csv listings.csv preclean.R
	R --vanilla < pre_clean.R
	

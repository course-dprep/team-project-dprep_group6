# Define variables
RFILE := regression_analysis.R

# Define targets
all: run

# Define rules
run:
	R --vanilla < $(RFILE)

.PHONY: clean
clean:
	rm -rf gen/output/*   # Clean generated files

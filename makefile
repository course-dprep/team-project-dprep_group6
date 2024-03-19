# Define targets
all: cleaned_filtered_data regression_analysis

clean:
    # Remove any generated files
    rm -rf src/data_prep/*.csv

cleaned_filtered_data:
    # Use a tab character for indentation
    R --vanilla < src/cleaned_filtered_data.R

regression_analysis:
    # Use a tab character for indentation
    R --vanilla < src/regression_analysis.R

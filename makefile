all: analysis

data-preparation:
	make -C src/data_prep

analysis: data-preparation
	make -C src/analysis

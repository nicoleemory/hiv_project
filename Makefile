hiv_report_config_${WHICH_CONFIG}.html: code/04_render_report.R hiv_report.Rmd descriptive_analysis regression_analysis
	Rscript code/04_render_report.R

# the syntax of make is that you want to specify the target of the rule, which is data/output/data_clean.rds
# and then you add a colon and all of the pre-requisites for that object; a list of objects that we use to make that target
# the objects list is separated by spaces
data/output/data_clean.rds: code/00_clean_data.R data/raw_data/vrc01_data.csv

# next, we write our action statement
# use the tab key on a new line of code and then the code that we would like to execute
	Rscript code/00_clean_data.R 
	
data/output/table_one.rds: code/01_make_table1.R data/output/data_clean.rds

	Rscript code/01_make_table1.R

data/output/scatterplot.png: code/02_make_scatter.R data/output/data_clean.rds

	Rscript code/02_make_scatter.R
	
.PHONY: descriptive_analysis
descriptive_analysis: data/output/table_one.rds data/output/scatterplot.png

data/output/both_models_config_${WHICH_CONFIG}.rds data/output/both_regression_tables_config_${WHICH_CONFIG}.rds&: code/03_models.R data/output/data_clean.rds
	Rscript code/03_models.R

.PHONY: regression_analysis
regression_analysis: data/output/both_models_config_${WHICH_CONFIG}.rds data/output/both_regression_tables_config_${WHICH_CONFIG}.rds

.PHONY: clean
clean:
	rm -f data/output/*.rds && rm -f data/output/*png rm -f *.html
# the && means execute the command after the && only if the stuff before the && executes succesfully
	
	
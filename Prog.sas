/* Permanent library creation */
LIBNAME mycars '/home/u62009805/Assignment1'; /* Replace with your library path */

/* Step 1: Data Preparation and data cleaning */
DATA mycars.cleaned_cars;
  INFILE '/home/u62009805/Assignment1/USEuropeCars.csv' DSD FIRSTOBS=2; /* Update path */
  INPUT Observation region $ horsepower mpg_before mpg_after;
  
  /* Remove Observation variable */
  DROP Observation;
  
  /* Exclude Asia region */
  IF region NE 'Asia';
  
  /* Remove outlier (Observation 38: mpg_before=999) */
  IF mpg_before < 100;
  
  /* Create average gas mileage variable */
  avg_mpg = (mpg_before + mpg_after) / 2;
RUN;


/* Step 2: Visualizations */
/* i) Creating Histogram for horsepower */
proc sgplot data=mycars.cleaned_cars;
	histogram horsepower / group=region TRANSPARENCY=0.5;
	density horsepower / type=kernel;
	TITLE "Horsepower Distribution by Region";
run;

/* ii) Creating Histogram for mpg before*/
proc sgplot data=mycars.cleaned_cars;
	histogram mpg_before / group=region TRANSPARENCY=0.5;
	density mpg_before / type=kernel;
	TITLE "MPG Before Distribution by Region";
run;

/* iii) Creating Histogram for mpg after*/
proc sgplot data=mycars.cleaned_cars;
	histogram mpg_after / group=region TRANSPARENCY=0.5;
	density mpg_after / type=kernel;
	TITLE "MPG After Distribution by Region";
run;

/* iv) Creating Histogram for average mpg*/
proc sgplot data=mycars.cleaned_cars;
	histogram avg_mpg / group=region TRANSPARENCY=0.5;
	density avg_mpg / type=kernel;
	TITLE "Average MPG Distribution by Region";
run;


/* Step 3:Plotting Scatterplots for numeric variables */
PROC SGSCATTER DATA=mycars.cleaned_cars;
	PLOT (horsepower mpg_before mpg_after avg_mpg)*(horsepower mpg_before 
		mpg_after avg_mpg) / GROUP=region MARKERATTRS=(SIZE=7);
	TITLE "Relationships Between Variables";
RUN;


/* Step 4: Distribution Fitting*/
/* Gamma distribution for horsepower */
	PROC UNIVARIATE DATA=mycars.cleaned_cars;
		VAR horsepower;
		CDFPLOT horsepower / GAMMA(theta=EST sigma=EST alpha=EST);
		QQPLOT horsepower / GAMMA(theta=EST sigma=EST alpha=EST);
		TITLE "Gamma Fit for Horsepower";
	RUN;
	
	
	/* Gamma distribution for mpg_before */
	PROC UNIVARIATE DATA=mycars.cleaned_cars;
	  VAR mpg_before;
	  CDFPLOT mpg_before / GAMMA(theta=EST sigma=EST alpha=EST);
	  QQPLOT mpg_before / GAMMA(theta=EST sigma=EST alpha=EST);
	  TITLE "Gamma Fit for MPG BEFORE";
	RUN;
	
	/* Weibull distribution for mpg_before */
	PROC UNIVARIATE DATA=mycars.cleaned_cars;
		VAR mpg_before;
		CDFPLOT mpg_before / WEIBULL(theta=EST sigma=EST c=EST);
		QQPLOT mpg_before / WEIBULL(theta=EST sigma=EST c=EST);
		TITLE "Weibull Fit for MPG Before";
	RUN;


/* Step 5:90% CI for mean horsepower */
/* Re-import data without excluding Asia */
DATA mycars.cleaned_cars_all;
	INFILE '/home/u62009805/Assignment1/USEuropeCars.csv' DSD FIRSTOBS=2;

	/* Update path */
	INPUT Observation region $ horsepower mpg_before mpg_after;

	/* Drop Observation variable */
	DROP Observation;

	/* Remove outlier (Observation 38: mpg_before=999) */
	IF mpg_before < 100;

	/* Create average gas mileage variable */
	avg_mpg=(mpg_before + mpg_after) / 2;
RUN;


/* Calculate 90% CI for mean horsepower (including Asia) */
PROC MEANS DATA=mycars.cleaned_cars_all ALPHA=0.10 N MEAN CLM;
	VAR horsepower;
	TITLE "90% Confidence Interval for Mean Horsepower (All Regions)";
RUN;


/* Step 6: 95% CI for avg_mpg (Europe vs. USA) */
PROC TTEST DATA=mycars.cleaned_cars COCHRAN;
	CLASS region;
	VAR avg_mpg;
	WHERE region IN ('Europe', 'USA');
	TITLE "95% CI for Average MPG: Europe vs. USA";
RUN;

/* Step 7: 99% CI for mean difference (mpg_after - mpg_before) */
PROC TTEST DATA=mycars.cleaned_cars ALPHA=0.01;
	PAIRED mpg_after*mpg_before;
	TITLE "99% CI for MPG After-Before Difference";
RUN;
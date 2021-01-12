# ACF 

- [ACF](#acf)
  - [Auto Correlation Function Estimation](#auto-correlation-function-estimation)
  - [Usage](#usage)
  - [Arguments](#arguments)
  - [Details](#details)
  - [Examples](#examples)

## Auto Correlation Function Estimation

the function ```ACF``` computes and plots estimates of the auto-correlation function. 

## Usage 
``` matlab
acf = ACF(X)
acf = ACF(X,lag)
```

## Arguments 
| | |
| --- | --- |
|*X* | Univariate numeric time series or vector 
|*lag* | Maximum lag at which to calculate the auto correlation factor. Default value is $1\log_{10}(N/m)$ where $N$ is the number of observations and $m$ one less than the number of observations in the series. 


## Details 
By default, missing values are allowed. 

## Examples 
``` matlab 



```




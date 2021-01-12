# Outlier

- [Outlier](#outlier)
  - [Outlier Detection](#outlier-detection)
  - [Usage](#usage)
  - [Arguments](#arguments)
  - [Details](#details)
    - [IQR method](#iqr-method)
    - [Hampel filter](#hampel-filter)
  - [Examples](#examples)

## Outlier Detection 

Detect outliers from univariate data using several methods. 

## Usage 
``` matlab
[idx, I]= Outlier(Data, method)
```

## Arguments 
| | |
| --- | --- |
|*Data* | Univariate numeric vector 
|*method* | character input of which method to use. By default will use IQR (interquartile range). Can input 'Hampel' to use the Hampel filter method. 


## Details 
### IQR method 
Q1 and Q3 are the first and third quartiles, respectively. IQR is the interquartile range $IQR = Q3 - Q1$. Values above $Q3 + 1.5*IQR$ or below $Q1 - 1.5*IQR$ are considered outliers. 

### Hampel filter 
A Hampel filter can be used to replace outliers in a dataset but this implementation is only interested in identifying them. For any point in the input data, if it is more than $3\sigma$ away from the median value then the Hampel filter identifies that point as an outlier. 

## Examples 
``` matlab 



```




# PCA

- [PCA](#pca)
  - [Principal Components Analysis](#principal-components-analysis)
  - [Usage](#usage)
  - [Arguments](#arguments)
  - [Output](#output)
  - [Details](#details)
  - [Examples](#examples)

## Principal Components Analysis 

Performs a principal components analysis on the given data matrix or table and returns the results as a MATLAB struct. 

## Usage 
``` matlab
output = PCA(Data)
```

## Arguments 
| | |
| --- | --- |
|*Data* | A table or matrix containing the variables for which to generate the rotation. 

## Output
| | |
| --- | --- |
|*dev* | cumulative percentage of variance explained by each new variable 
|*rotation*| rotation vector. Allows the same rotation to be applied to new data 
|*cntr*| output from [standardize](../ML%20package/standardize.m) function to apply the same normalization to new data 
|*XV*| new rotated Data. 

## Details 
PCA is used in exploratory data analysis, commonly used for dimensionality reduction by creating a projection that contains the most amount of variance in the smallest number of vectors. The first component is the direction that maximizes the variance of the projected data. Each subsequent component is a direction orthogonal to the previous components and maximizes the remaining variance of the projected data. Principal components are eigenvectors of the data's covariance matrix. 

## Examples 
``` matlab 



```




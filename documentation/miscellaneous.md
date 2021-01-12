# Miscellaneous Functions 

- [Miscellaneous Functions](#miscellaneous-functions)
  - [audit](#audit)
  - [range](#range)
  - [resample](#resample)
  - [stderror](#stderror)
  - [Swap](#swap)

## audit 
Mimics the 'summary' function in R. Returns min, 1st quartile, median, mean, 3rd quartile, max. The quantiles can be changed with a and b. 
```matlab
out = audit(Data)
out = audit(Data, a, b) 
```


## range 
range of input vector
```matlab
    dif = range(X)
```

## resample 
resample data with or without replacement 
```matlab
resampled = resample(Data, obs)
resampled = resample(Data, obs, 1)
```

## stderror
calculate standard error of the mean 
```
e = stderror(X)
```

## Swap
Swap two items with each other. 
```matlab
    [b,a] = swap(a,b)
```


function [p, stats] = anova(Data,tails)
% Syntax: [p, stats] = anova(Data,group,tails)
%
% Long description
%Inputs: 
% Data = vector or matrix of sample data 
% tails = 1 for one-way ANOVA and 2 for two-way ANOVA
%Outputs: 
    
[a,b] = dim(Data);
% assume 1 tail anova if not specified 
if ~exist('tails','var') 
    tails = 1;
end

%1. calculate the sample means for each sample and for total 
tot_mean = mean(Data,'all');
smpl_mean = mean(Data);
%2. calcualte sum of square error
 SE = sum((Data - smpl_mean).^2);
 SSE = sum(SSE);

%3. sum of squares of treatment 
 SST = sum((smpl_mean-tot_mean).^2);
 trea = b-1;
 SST = (trea)*SST;

%4. Degrees of Freedom
df = a - trea;

%5. Mean Squares 
SSE = SSE/df;
SST = SST/df;
end
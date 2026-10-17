function [meanVal,stdVal,rmsVal,maxVal,kurtosisVal] = feature_extract(table_1,n)

tbl=table_1;
meanVal= mean(tbl(:,n), 1);
stdVal= std(tbl(:,n), 0, 1);
rmsVal= rms(tbl(:,n), 1);
maxVal= max(tbl(:,n), [], 1);
kurtosisVal= kurtosis(tbl(:,n), 1);

end
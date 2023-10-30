[FileName,PathName]=uigetfile('.TIF','select the multispektral image');
x=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','select the fused image');
y=imread(FileName);

%x=imresize(x,[1649 1857]);

%%RASE
sizi=size(x);
if max(size(size(x))) == 2
    bands = 1;
else
    bands = sizi(1,3);
end
nres = sizi(1,1)*sizi(1,2);
rmses = zeros(bands,1); 
Ms   = zeros(bands,1);
for i = 1:bands             
    xt = double(x(:,:,i));  
    yt = double(y(:,:,i)); 
    rmses(i) = sqrt((sum(sum((xt - yt).^2)))/nres);
    % Mean xs for RASE
    Ms(i)      = mean2(x(:,:,i));
end

% RASE part

rmsesquared = rmses.^2;
srmsesq     = sum(rmsesquared);
M           = mean(x(:));
% Total RASE
rase_tl     = (100/M)*(sqrt(srmsesq/bands));
% RASE per band
rase_pb     = (100./Ms).*sqrt(rmsesquared);
% Average RASE
av_rase     = mean(rase_pb);
% End of RASE part
%%  bias
bands = size(x);
if length(bands) == 3
    bands = bands(1,3);
else
    bands = 1;
end

% Preallocation

mx = zeros(1,bands);
my = zeros(1,bands);
%Mean value calculation
for i = 1:bands
    xt = double(x(:,:,i));
    yt = double(y(:,:,i));
    mx(i) = mean(xt(:));
    my(i) = mean(yt(:));
end

% Bias calculation
bias = 1 - (my./mx);
av_bias = mean(bias);

%% CC 
% Find the number of bands
bands = size(x);
if length(bands) == 3
    bands = bands(1,3);
else
    bands = 1;
end

% Preallocation

cc = zeros(bands,1);
% Correlation Coefficient calculation

for i = 1:bands
    xt = double(x(:,:,i));
    yt = double(y(:,:,i));
    cc(i) = corr2(xt,yt);    
end
% Average CC

av_cc = mean(cc);
%% Q index

bands = size(x);
if length(bands) == 3
    bands = bands(1,3);
else
    bands = 1;
end

% Preallocation

meansx = zeros(bands,1);
meansy = zeros(bands,1);
sdsx   = zeros(bands,1);
sdsy   = zeros(bands,1);
cc     = zeros(bands,1);
for i = 1:bands;    
    xt = double(x(:,:,i));
    yt = double(y(:,:,i));
    % Statistics for each band
    meansx(i) = mean(xt(:));
    meansy(i) = mean(yt(:));
    sdsx(i)   = std2(xt);
    sdsy(i)   = std2(yt);
    % Correlation Coefficient for each band
    cc(i) = corr2(xt,yt);
end

% Quality for each band

qs = (  ( cc .* ( (2.*meansx.*meansy) ./ (meansx.^2 + meansy.^2)  ) 
             .* ( (2.*sdsx  .*sdsy  ) ./ (sdsx.^2 + sdsy.^2) ) )  ) ;    
             
% Calculate mean quality and mean correlation coefficient
av_q  = mean(qs);
av_cc = mean(cc);

%% ERGAS

R1=double(M1);
R2=double(IM_atrous2);
Err=R1-R2;
ERGAS_index=0;
for iLR=1:size(Err,3)
    ERGAS_index = ERGAS_index+mean2(Err(:,:,iLR).^2)/(mean2((R1(:,:,iLR))))^2;   
end
ERGAS_index = (100/1) * sqrt((1/size(Err,3)) * ERGAS_index);

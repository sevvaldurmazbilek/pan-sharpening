%Image Fusion with PCA Method 

[FileName,PathName]=uigetfile('.TIF','band1');
b1=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','band2');
b2=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','band3');
b3=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','band4');
b4=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','band5');
b5=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','band6');
b6=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','band7');
b7=imread(FileName);
M1=cat(7,b1,b2,b3,b4,b5,b6,b7);
[FileName,PathName]=uigetfile('.TIF','select the Panchromatic Band');
P1=imread(FileName);

%%resize
[height width band]=size(M1);
[height1 width1]=size(P1);
ratio=[height1/height width1/width];
oldSize = size(M1);                  
newSize = max(floor(ratio.*oldSize(1:2)),1);
rowIndex = min(round(((1:newSize(1))-0.5)./ratio(1)+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./ratio(2)+0.5),oldSize(2));
M1 = M1(rowIndex,colIndex,:);

%%pca
X=double(reshape(M1,numel(M1)/3,3));
mu = sum(X) / size(X,1);
X_mean_subtract = bsxfun(@minus, X, mu);
corrcoef(X_mean_subtract(:,:,1),double(P1(:)));
corrcoef(X_mean_subtract(:,:,2),double(P1(:)));
corrcoef(X_mean_subtract(:,:,3),double(P1(:)));
corrcoef(X_mean_subtract(:,:,4),double(P1(:)));
corrcoef(X_mean_subtract(:,:,5),double(P1(:)));
corrcoef(X_mean_subtract(:,:,6),double(P1(:)));
corrcoef(X_mean_subtract(:,:,7),double(P1(:)));
Z=X_mean_subtract;
Z(:,:,1)=(double(P1(:)-min(P1(:)))./double(max(P1(:))-min(P1(:))))*(max(X_mean_subtract(:,:,1))-min(X_mean_subtract(:,:,1)))+min(X_mean_subtract(:,:,1));
covX = (X_mean_subtract.' * X_mean_subtract) / (size(X,1) - 1);
W=Z*covX';
I_new = (W - min(W(:)))/(max(W(:))-min(W(:)));
I_PCA = reshape(I_new, size(M1));
subplot(2,1,1),imshow(M1),title('Original Multispectral Image');
subplot(2,1,2),imshow(I_PCA),title('Fused Image with PCA');
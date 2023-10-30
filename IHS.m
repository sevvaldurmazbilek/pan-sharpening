%Image Fusion with IHS Method 
%%dataset

[FileName,PathName]=uigetfile('.TIF','select the Red Band');
R=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','select the Green Band');
G=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','select the Blue Band');
B=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','select the Panchromatic Band');
P=imread(FileName);

%%cropping

R=imcrop(R,[4000 1370 4400-4000 1570-1370]);
G=imcrop(G,[4000 1370 4400-4000 1570-1370]);
B=imcrop(B,[4000 1370 4400-4000 1570-1370]);
P1=imcrop(P,[8000 2740 8800-8000 3140-2740]);
M=cat(3,R,G,B);

%%resize

[height width band]=size(R);
[height1 width1]=size(P1);
ratio=[height1/height width1/width];
oldSize = size(R);                  
newSize = max(floor(ratio.*oldSize(1:2)),1);
rowIndex = min(round(((1:newSize(1))-0.5)./ratio(1)+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./ratio(2)+0.5),oldSize(2));
M=M(rowIndex,colIndex,:);
R=R(rowIndex,colIndex,:);
G=G(rowIndex,colIndex,:);
B=B(rowIndex,colIndex,:);

%% IHS

R=im2double(R);
G=im2double(G);
B=im2double(B);
P1=im2double(P1);
M=im2double(M);
pay=1/2*((R-G)+(R-B));
payda=sqrt((R-G).^2+((R-B).*(G-B)));
T=acosd(pay./payda);
if B<=G;
 H=T;
else
 H=360-T;
end
Ha=H/360;
S=1-(3./(sum(M,3)).*min(M,[],3));
I=(1/3).*(sum(M,3));
HSI=cat(3,Ha,S,I);
F1=R+(P1-I);
F2=G+(P1-I);
F3=B+(P1-I);
IM_IHS(:,:,1)=F1;
IM_IHS(:,:,2)=F2;
IM_IHS(:,:,3)=F3;
subplot(2,1,1),imshow(M),title('Original Multispectral Image');
subplot(2,1,2),imshow(IM_IHS),title('Fused Image with IHS Method');
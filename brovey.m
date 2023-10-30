%%dataset
[FileName,PathName]=uigetfile('.TIF','select the Red Band');
R=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','select the Green Band');
G=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','select the Blue Band');
B=imread(FileName);
[FileName,PathName]=uigetfile('.TIF','select the Panchromatic Band');
P=imread(FileName);

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

%%brovey

R=im2double(R);
G=im2double(G);
B=im2double(B);
P1=im2double(P1);
RN=(R./((R+G+B)/3)).*P1;
GN=(G./((R+G+B)/3)).*P1;
BN=(B./((R+G+B)/3)).*P1;
IM_brovey(:,:,1)=RN;
IM_brovey(:,:,2)=GN;
IM_brovey(:,:,3)=BN;
subplot(2,1,1),imshow(M),title('Original Multispectral Image');
subplot(2,1,2),imshow(IM_brovey),title('Fused Image with Brovey Method');
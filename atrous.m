%% dataset

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

[height, width, band]=size(M1);
[height1, width1]=size(P1);
ratio=[height1/height width1/width];
oldSize = size(M1);                  
newSize = max(floor(ratio.*oldSize(1:2)),1);
rowIndex = min(round(((1:newSize(1))-0.5)./ratio(1)+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./ratio(2)+0.5),oldSize(2));
M1 = M1(rowIndex,colIndex,:);
%%a trous

P1=im2double(P1);
H0=[1 4 6 4 1;4 16 24 16 4;6 24 36 24 6;4 16 24 16 4;1 4 6 4 1].*(1/256); %kernel
sz=2; 
[x,y]=meshgrid(-sz:sz,-sz:sz);
M=size(x,1)-1;
N=size(y,1)-1;
for i=1:size(P1,1)-M
    for j=1:size(P1,2)-N
        conv=P1(i:i+M,j:j+M).*H0;
        I1(i,j)=sum(conv(:));
    end
end
H1=[1 0 4 0 6 0 4 0 1;0 0 0 0 0 0 0 0 0;4 0 16 0 24 0 16 0 4;0 0 0 0 0 0 0 0 0;6 0 24 0 36 0 24 0 6;0 0 0 0 0 0 0 0 0;4 0 16 0 24 0 16 0 4;0 0 0 0 0 0 0 0 0;1 0 4 0 6 0 4 0 1].*(1/256);
sz=4;
[x,y]=meshgrid(-sz:sz,-sz:sz);
M=size(x,1)-1;
N=size(y,1)-1;
for i=1:size(P1,1)-M
    for j=1:size(P1,2)-N
        conv=P1(i:i+M,j:j+M).*H1;
        I2(i,j)=sum(conv(:));
    end
end
H2=[1 0 0 4 0 0 6 0 0 4 0 0 1;0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0;4 0 0 16 0 0 24 0 0 16 0 0 4;0 0 0 0 0 0 0 0 0 0 0 0 0 ;0 0 0 0 0 0 0 0 0 0 0 0 0;6 0 0 24 0 0 36 0 0 24 0 0 6;0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0;4 0 0 16 0 0 24 0 0 16 0 0 4;0 0 0 0 0 0 0 0 0 0 0 0 0 ;0 0 0 0 0 0 0 0 0 0 0 0 0;1 0 0 4 0 0 6 0 0 4 0 0 1].*(1/256);
sz=6;
[x,y]=meshgrid(-sz:sz,-sz:sz);
M=size(x,1)-1;
N=size(y,1)-1;
for i=1:size(P1,1)-M
    for j=1:size(P1,2)-N
        conv=P1(i:i+M,j:j+M).*H2;
        I3(i,j)=sum(conv(:));
    end
end
[height, width]=size(I1);
[height1, width1]=size(P1);
ratio=[height1/height width1/width];
oldSize = size(I1);                  
newSize = max(floor(ratio.*oldSize(1:2)),1);
rowIndex = min(round(((1:newSize(1))-0.5)./ratio(1)+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./ratio(2)+0.5),oldSize(2));
I1 = I1(rowIndex,colIndex,:);
[height, width]=size(I2);
ratio=[height1/height width1/width];
oldSize = size(I2);
newSize = max(floor(ratio.*oldSize(1:2)),1);
rowIndex = min(round(((1:newSize(1))-0.5)./ratio(1)+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./ratio(2)+0.5),oldSize(2));
I2 = I2(rowIndex,colIndex,:);
I3=imresize(I3,I2);
w1=P1-I1;
w2=I1-I2;
w3=I2-I3;
W=w1+w2+w3;
I_MS=im2double(M1);
IM_atrous=I_MS+W;
subplot(2,1,1),imshow(M1),title('Original Multispectral Image');
subplot(2,1,2),imshow(IM_atrous),title('Fused Image with A Trous');
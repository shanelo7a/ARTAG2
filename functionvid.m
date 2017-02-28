clc
clear all 
clear all figures
s0= vid('Tag0.mp4');
s1= vid('Tag1.mp4');
s2= vid('Tag2.mp4');
T0 = (s0(448).cdata);
T1 = (s1(325).cdata);
T2 = (s2(495).cdata);
[TAG0,CRP0] = im(T0);
[TAG1,CRP1] = im(T1);
[TAG2,CRP2] = im(T2);
A0 = SS(CRP0);
A1 = SS(CRP1);
A2 = SS(CRP2);
NUM0 = CC(A0);
NUM1 = CC(A1);
NUM2 = CC(A2);
%[TT,RR,QQ] = harris(CRP0,0.1,0.4); Do this is the harris comand that I
%tried 
function s = vid(video)
vidObj = VideoReader(video);
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'));
k = 1;

while hasFrame(vidObj)
    s(k).cdata = readFrame(vidObj);
    k = k+1;
end
end

function [BW,CROP] = im(image)
T_Gaus= imgaussfilt(image);
BW = im2bw(T_Gaus,0.9);
BB = regionprops(~BW,'BoundingBox');
CROP = imcrop (BW, [BB(2).BoundingBox]);
  
end
function [ARRAY] = SS(image)
[R,C] = size(image);
L=floor(R/8);
W=floor(C/8);
for m = 1:8
    for n = 1:8
        ARRAY(m,n) = image(round(L/2+(m-1)*L),round(W/2+(n-1)*W));
    end
end
end
function [NUM] = CC(array)
D = array;
if D(4,5)==1&&D(5,4)==1
    NUM =0
else 
    if D(4,5)==0 
        NUM = 2
    else
        NUM =1
    end
end
end



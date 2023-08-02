clc; close all; clear all;

image=imread('../raw/jabee.jpeg');
imshow(image),title('original image');
%% 

img=rgb2gray(image);
imshow(img);title('Grayscale');
%% 

BNW=edge(img,'canny');
imshow(BNW), title('Outlining');
%% 

[H,T,R] = hough(BNW);

imshow(imadjust(rescale(H)),[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,cool)

P = houghpeaks(H,8);
x = T(P(:,2));
y = R(P(:,1));
plot(x,y,'s','color','black','LineWidth',1);
title('Parameter Plane for Hough Transform');
%%  

line=houghlines(BNW,T,R,P,"FillGap",5,"MinLength",7);
figure, imshow(BNW),hold on; title('Detected Lines using Hough Transformation');
for k=1:length(lines)
    xy = [line(k).point1; line(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
end


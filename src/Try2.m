clear all; clc; close all;
I = im2double(imread('flower.jpg'));
%figure, imshow(I);
%x=198; y=359;

J = regiongrowing(I,0.2); 
figure, imshow(J+I);title('Segmented Image')
impixelinfo;
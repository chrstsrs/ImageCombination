close all;  

% Διαβάζει την 1η εικόνα
% Reads the 1st image
im1=imread('foto1a.jpg');
% Αν η εικόνα δεν έχει ήδη ανάλυση 513χ513 μπορούμε να βγάλουμε το σχόλιο
% από την παρακάτω γραμμή
% Change the resolution of the 1st image to 513x513.
im1=imresize(im1, [513 513]);
im1=double(im1); 

% Όμοια για τη 2η εικόνα
% The same process for the second image
im2=imread('foto2a.jpg');
im2=imresize(im2, [513 513]);
im2=double(im2); 

% Kernel
x=[1, 4, 7, 4, 1];
BoxKernel=x'*x;

% Image1
figure; imshow(uint8(im1));

% Gause Πυραμίδα για το Image1
% Gause Pyramid for the Image1
G1im1=convolve(im1,BoxKernel);
G2im1=convolve(G1im1,BoxKernel);
G3im1=convolve(G2im1,BoxKernel);
G4im1=convolve(G3im1,BoxKernel);

%Εμφάνιση των εικόνων
%Image appearance
%figure; imshow(uint8(G1im1));
%figure; imshow(uint8(G2im1));
%figure; imshow(uint8(G3im1));
%figure; imshow(uint8(G4im1));

%Laplacian Πυραμίδα για το Image1
%Laplacian Pyramid for the Image1
L1im1=im1-recons(G1im1,BoxKernel);
L2im1=G1im1-recons(G2im1,BoxKernel);
L3im1=G2im1-recons(G3im1,BoxKernel);
L4im1=G3im1-recons(G4im1,BoxKernel);

%Εμφάνιση των εικόνων
%Image appearance
%figure, imshow(uint8(L1im1));
%figure, imshow(uint8(L2im1));
%figure, imshow(uint8(L3im1));
%figure, imshow(uint8(L4im1));

%Ανακατασκευή της αρχικής εικόνας
%Reconstruct the initial image
T4im1=L4im1+recons(G4im1,BoxKernel);
T3im1=L3im1+recons(T4im1,BoxKernel);
T2im1=L2im1+recons(T3im1,BoxKernel);
T1im1=L1im1+recons(T2im1,BoxKernel);

figure, imshow(uint8(T1im1));

%Image2
figure; imshow(uint8(im2));

%Gause Πυραμίδα για το Image2
%Gause Pyramid for the Image2
G1im2=convolve(im2,BoxKernel);
G2im2=convolve(G1im2,BoxKernel);
G3im2=convolve(G2im2,BoxKernel);
G4im2=convolve(G3im2,BoxKernel);

%Εμφάνιση των εικόνων
%Image appearance
%figure; imshow(uint8(G1im2));
%figure; imshow(uint8(G2im2));
%figure; imshow(uint8(G3im2));
%figure; imshow(uint8(G4im2));

%Laplacian Πυραμίδα για το Image2
%Laplacian Pyramid for the Image2
L1im2=im2-recons(G1im2,BoxKernel);
L2im2=G1im2-recons(G2im2,BoxKernel);
L3im2=G2im2-recons(G3im2,BoxKernel);
L4im2=G3im2-recons(G4im2,BoxKernel);

%figure, imshow(uint8(L1im2));
%figure, imshow(uint8(L2im2));
%figure, imshow(uint8(L3im2));
%figure, imshow(uint8(L4im2));

%Ανακατασκευή της αρχικής εικόνας
%Reconstruct the initial image
T4im2=L4im2+recons(G4im2,BoxKernel);
T3im2=L3im2+recons(T4im2,BoxKernel);
T2im2=L2im2+recons(T3im2,BoxKernel);
T1im2=L1im2+recons(T2im2,BoxKernel);

figure, imshow(uint8(T1im2));

% Η μάσκα για τη σύνθεση των δύο εικόνων
% The mask that combines the two images
m513=double(imread('mask.jpg'));
% Αν και πάλι δεν έχει ανάλυση 513χ513 θα πρέπει να βγάλουμε το σχόλιο από
% την παρακάτω γραμμή
% Changes the resulotion to 513x513
m513=imresize(m, [513, 513]);

%Gausian για τη μάσκα
%Gausian for the mask
G1M257=convolve(m513,BoxKernel);
G2M129=convolve(G1M257,BoxKernel);
G3M65=convolve(G2M129,BoxKernel);
G4M33=convolve(G3M65,BoxKernel);

%Αλλαγή τιμών στο [0,1] ώστε να χρησιμοποιηθούν για βάρη
%Change values to [0,1] that can be used as weight
m513=m513/255;
G1M257=G1M257/255;
G2M129=G2M129/255;
G3M65=G3M65/255;
G4M33=G4M33/255;

% Υπολογισμός των συμπληρωματικών βαρών
% Calculation of supplementary weights 
mr513=1-m513;
mr257=1-G1M257;
mr129=1-G2M129;
mr65=1-G3M65;
mr33=1-G4M33;

% Η νέα L πυραμίδα
% The new pyramid
G4Mim1=G4im1 .* mr33;
L4Mim1=L4im1 .* mr65;
L3Mim1=L3im1 .* mr129;
L2Mim1=L2im1 .* mr257;
L1Mim1=L1im1 .* mr513;

G4Mim2=G4im2 .* G4M33;
L4Mim2=L4im2 .* G3M65;
L3Mim2=L3im2 .* G2M129;
L2Mim2=L2im2 .* G1M257;
L1Mim2=L1im2 .* m513;

%figure, imshow(uint8(L1Mim1));
%figure, imshow(uint8(L2Mim1));
%figure, imshow(uint8(L3Mim1));
%figure, imshow(uint8(L4Mim1));

% Σύνθεση της νέας εικόνας
% Composition of the new image
G4M=G4Mim1+G4Mim2;

L1M=L1Mim1+L1Mim2;
L2M=L2Mim1+L2Mim2;
L3M=L3Mim1+L3Mim2;
L4M=L4Mim1+L4Mim2;

T4M=L4M+recons(G4M,BoxKernel);
T3M=L3M+recons(T4M,BoxKernel);
T2M=L2M+recons(T3M,BoxKernel);
T1M=L1M+recons(T2M,BoxKernel);

%figure, imshow(uint8(G4M));
%figure, imshow(uint8(T4M));
%figure, imshow(uint8(T3M));
%figure, imshow(uint8(T2M));
figure, imshow(uint8(T1M));

% Κατασκευή της υβριδικής εικόνας
% Construction of the hybrid image
TH3=L3im1+recons(T4im2,BoxKernel);
TH2=L2im1+recons(TH3,BoxKernel);
TH1=L1im1+recons(TH2,BoxKernel);

figure, imshow(uint8(TH1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  This MATLAB code converts 32bit images into 8bit images and save the
%  new 8bit images into a new folder. For its design, it operates on a 
%  folder, which could contain other sub-folders, containing the images.  
%   
%  The script converts the 32 bit images into 8 bit and saves the converted 
%  images into a new folder having the same name of the
%  folder that contained the original 32 bit images. 

%  Example:
%  The script operates on "SCAN_folder" which contains "74a", 
%  which in turn contains "Image1(32bit)", "Image2(32bit)", "Image3(32bit)"

%  The script opens "SCAN_folder", then "74a" and converts its  
%  Image1(32bit), Image2(32bit) and Image3(32bit) into 
%  Image1(8bit), Image2(8bit) and Image3(8bit) respectively.  
%  Then "Image1(8bit)", "Image2(8bit)", "Image3(8bit)" are saved  
%  into a new folder called "74a".

%  Insert here the path of the input "SCAN_folder": 
   cd E:\..\SCAN_folder 

%  If there are multiple sub-folders into "SCAN_folder", it is convenient 
%  to name these folders with a common pattern. 
%
%  For example in our case the input folders are named all with a 
%  string starting with "74", for example 74a, 74b, 74c, etc...

%  Put in the brackets the common pattern followed by a star symbol
   dataname = dir('74*');
   Min = -0.005; %Minimum greyvalue of the 32bit images taken from their greyscale histograms
   Max = 0.005;  %Maximum greyvalue of the 32bit images taken from their greyscale histograms
   
%  This 'for' loop goes inside each folder containing the 32bit images.
%  If you have 74a inside SCAN_folder it will open 74a 

 for i =1:length(dataname)
     
    cd G:\  %Output folder, where you want to save the 8bit images
    mkdir(dataname(i).name); %it creates destination subfolders 
    
    cd E:\..\SCAN_folder  
    cd(dataname(i).name)
    imname = dir('*.tif'); % The loop opens each file in .tif format 
    
    % Once inside the folder, a 'for' loop converts the images one-by-one
   
   for j=1:2159 % In this case each folder has a total of 2159 images
     
    cd E:\..\SCAN_folder\  
    cd(dataname(i).name)
    im = imread(imname(j).name);              % The script reads the image
    im = im(1:2560, 1:2560);                  % It crops the image if necessary
    newMax = 2^8-1;                           % The maximum greyscale of the output image (255 for 8bit images)
    newMin = 1;                               % The minimum greyscale of the output image (0 for 8bit images, here set to 1)
    factor = (newMax-newMin)/(Max-Min);       % It computes the scale factor of the 32-to-8 bit conversion
    im8 = uint8(((im-Min).*factor)+newMin);   % It creates the new 8bit image
    clear im_crop im
    
    % Save the 8bit images in the output folder 
    cd G:\                                   
    cd(dataname(i).name) 
    imwrite(im8,imname(j).name);
    clear im8
      
   end
   
   i;
 end
 
 % Last update: 14/08/2018
 % E-mail: cosimo.ligorio@postgrad.manchester.ac.uk
 
 

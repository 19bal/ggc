% To run code:
%   - copy all files in Matlab current directory (C:/.../Matlab/work by default)
%   - type "gaitrec" on Matlab command window
%   - a simple and intuive GUI should appear
%
% Requirements:
%   - Matlab
%   - Matlab Image Processig Toolbox
%
% Notes:
%   - code receives as input the silhouettes of gait images. If you want to
%     use original video image pre-processing is necessary.
%     
% 
% Now you can:
%   - Select an input image sequence: just click on "Select image sequence"
%     button. You have to select a directory where the image sequence is stored.
%     Image sequence is a collection of white&black images with the silhouettes.
%     You can download a database of gait images at this URL
%     http://www.cbsr.ia.ac.cn/GaitDatasetA-silh.zip
%   - Add the selected image sequence to database: just click on "Add
%     selected image sequence to database" button. In this case you have to
%     specify gait ID: this ID is a progressive, integer number that is
%     associated to each person. Be sure that an input image sequence has
%     already been selected.
%   - Perform gait recognition: just click on "Gait Recognition" button.
%     Also in this cas you have to select the directory with unknown gait images. Code
%     returns the ID of the nearest person present in database.
%  
%
% References:
% CASIA Gait Database
% http://www.cbsr.ia.ac.cn/english/Gait%20Databases.asp
%
% Silhouettes are available at the following URLs:
% Dataset A (16 Mb):  http://www.cbsr.ia.ac.cn/GaitDatasetA-silh.zip
% Dataset B (628 Mb): http://www.cbsr.ia.ac.cn/GaitDatasetB-silh.zip
% Dataset C (66 Mb):  http://www.cbsr.ia.ac.cn/GaitDatasetC-silh.zip
%
%
% Functions:
%
% Select image sequence:                         read the image sequence
%
% Add selected image sequence to database:       the input image sequence is added to database and will be used for training
%
% Database Info:                                 show informations about the image sequences present in database. 
%
% Gait Recognition:                              gait recognition. The selected input image sequence is processed
%
% Delete Database:                               remove database from the current directory
%
% Program info:                                  show informations about this software
%
%
% Source code for Gait Recognition System:       how to obtain the complete source code
%
% Exit:                                          quit program
%
%

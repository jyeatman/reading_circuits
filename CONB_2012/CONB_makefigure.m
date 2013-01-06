%% This script will generate figure 1 from Wandell and Yeatman (2013)
% The script requires the Automated Fiber Quantification (AFQ), VISTASOFT
% and SPM software packages. More information can be found at 
% http://white.stanford.edu/newlm/index.php/AFQ
% or by emailing jyeatman@stanford.edu
%
% Copyright Jason D. Yeatman and Brian A. Wandell December 2012

%% Load files

% Get the subjects data directory
sdir = fullfile(fileparts(which('CONB_makefigure')),'data','s1');
% Load the callosum, arcuate and ILF fiber groups
cc = dtiLoadFiberGroup(fullfile(sdir,'Reading_Fibers','AngularGyrusCallosum.pdb'));
af = dtiLoadFiberGroup(fullfile(sdir,'Reading_Fibers','L_Arcuate_clean.pdb'));
ilf = dtiLoadFiberGroup(fullfile(sdir,'Reading_Fibers','L_ILF_cleaned.pdb'));
% Load the subject's t1 weighted image
t1 = readFileNifti(fullfile(sdir,'t1','t1.nii.gz'));

%% Render the Fibers

% Render the arcuate fasciculus in a new figure window. For the sake of
% computation time 100 fibers will be chosen at random for rendering. The
% output h is a handle for the light object in the figure window.
h = AFQ_RenderFibers(af,'color',[0 .5 1],'numfibers',100);
% Render the ILF in the same figure window
AFQ_RenderFibers(ilf,'color',[1 .5 0],'numfibers',100,'newfig',0);
% Render the corpus callosum in the same figure window
AFQ_RenderFibers(cc,'color',[0 .8 .2],'numfibers',100,'newfig',0);

%% Add a t1 weighted anatomy image as the background

% Add slice x = -1
AFQ_AddImageTo3dPlot(t1,[-1 0 0]);
% And slice z = -15
AFQ_AddImageTo3dPlot(t1,[0 0 -15]);

%% Rotate the image around

% Tilt down 15 degrees
camorbit(0,15);
% Add a new light to the scene
h = camlight(h,'right');
% Rotate 90 degrees in incriments of 10
for ii = 10:10:90
    % Rotate the camera 10 degrees
    camorbit(10,0);
    % Rotate the light with the camera
    camlight(h,'right');
    % Pause for .5 seconds
    pause(.5);
end
% Then rotate back to the starting position
for ii = 10:10:90
    camorbit(-10,0);
    camlight(h,'right');
    pause(.5);
end
% Tilt back up 15 degrees
camorbit(0,-15)

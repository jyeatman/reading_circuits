%% Load files
% Get the subjects data directory
sdir = fullfile(fileparts(which('CONB_makefigure')),'data','s1');
% Get the callosum arcuate and ilf fiber groups
cc = dtiLoadFiberGroup(fullfile(sdir,'Reading_Fibers','AngularGyrusCallosum.pdb'));
af = dtiLoadFiberGroup(fullfile(sdir,'Reading_Fibers','L_Arcuate_clean.pdb'));
ilf = dtiLoadFiberGroup(fullfile(sdir,'Reading_Fibers','L_ILF_cleaned.pdb'));

%% Render Fibers
% Render the fibers
AFQ_RenderFibers(af,'color',[0 .5 1],'numfibers',100)
AFQ_RenderFibers(ilf,'color',[1 .5 0],'numfibers',100,'newfig',0)
AFQ_RenderFibers(cc,'color',[0 .8 .2],'numfibers',100,'newfig',0)
% Add an slices from the t1 volume to the plots
t1 = readFileNifti(fullfile(sdir,'t1','t1.nii.gz'));
% Slice x = -1
AFQ_AddImageTo3dPlot(t1,[-1 0 0]);
% And slice z = -15
AFQ_AddImageTo3dPlot(t1,[0 0 -15]);

%% Render another image with fMRI activation from a rhyming task
% Add functional overlay of rhyming contrast
AFQ_RenderFibers(af,'color',[0 .5 1],'numfibers',100)
AFQ_RenderFibers(ilf,'color',[1 .5 0],'numfibers',100,'newfig',0)
AFQ_RenderFibers(cc,'color',[0 .8 .2],'numfibers',100,'newfig',0)
rhyme = readFileNifti(fullfile(sdir,'functional','Rhyme.nii.gz'));
AFQ_AddImageTo3dPlot(t1,[0 1 0],[],[],[],'overlay',rhyme,[3 6]);

%% Render ROIs
% % Load VWFA roi
% vwfa = dtiReadRoi(fullfile(sdir,'Reading_ROIs','VWFA.mat'));
% 
% % Load phonology ROIs
% temp = dtiReadRoi(fullfile(sdir,'Reading_ROIs','Phonology_Temporal.mat'));
% front = dtiReadRoi(fullfile(sdir,'Reading_ROIs','Phonology_Frontal.mat'));
% 
% % Render these ROIs
% AFQ_RenderRoi(vwfa,[1 0 0]);
% AFQ_RenderRoi(temp,[1 0 0]);
% AFQ_RenderRoi(front,[1 0 0]);


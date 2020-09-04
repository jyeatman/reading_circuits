t1 = niftiRead('t1_class.nii.gz');
t1.data = t1.data==3;
v1 = niftiRead('Occipital_Pole.nii.gz');
v1.data(v1.data>0) = 4;
vot = niftiRead('Ventral_larger.nii.gz');
vwfa = niftiRead('VWFA.nii.gz');
ips = niftiRead('IPS.nii.gz');

% Temporl
t = niftiRead('LateralTemp.nii.gz');
t.data=double(t.data)
t.data(t.data>0)=1.8;
t.data=smooth3(t.data,'box',5);

f = niftiRead('LateralFront.nii.gz');
f.data=double(f.data);
f.data(f.data>0)=1.6;
f.data=smooth3(f.data,'box',5);

vwfa.data(vwfa.data>0) = 2;
v1.data=smooth3(v1.data,'box',15);
v1.data=smooth3(v1.data,'gaussian',7);
vot.data=smooth3(vot.data,'box',9);
vot.data=smooth3(vot.data,'gaussian',7);
vwfa.data = smooth3(vwfa.data,'box',5);

ips.data(ips.data>0) = 2;
ips.data = smooth3(ips.data,'box',7);
%%
%v1.data(t1.data==0)=0;
msh = AFQ_meshCreate(t1,'boxfilter',5);

alldata = vwfa;
alldata.data = max(t.data + f.data, vwfa.data);
msh_final = AFQ_meshColor(msh,'overlay', alldata, 'thresh', .01, 'crange', [.001 2], 'cmap', 'autumn')
[~,~,lh]=AFQ_RenderCorticalSurface(msh_final)
view(-70,-5);axis off
camlight(lh,'infinite')
set(gca, 'Color', 'none');export_fig('Reading_Circuitry.png','-r300','-transparent')


% Different steps

msh1 = AFQ_meshColor(msh,'overlay', v1, 'thresh', .01, 'crange', [.001 2], 'cmap', 'autumn')
[~,~,lh]=AFQ_RenderCorticalSurface(msh1)
view(-70,-5);axis off
camlight(lh,'infinite')
set(gca, 'Color', 'none');export_fig('Reading_V1.png','-r300','-transparent')

vwfa.data = max(vwfa.data+vot.data,v1.data);
msh3 = AFQ_meshColor(msh,'overlay', vwfa, 'thresh', .01, 'crange', [.001 2], 'cmap', 'autumn')
[~,~,lh]=AFQ_RenderCorticalSurface(msh3)
view(-70,-5);axis off
camlight(lh,'infinite')
set(gca, 'Color', 'none');;export_fig('Reading_vot.png','-r300','-transparent');

t.data = max(vwfa.data,t.data);
msh4 = AFQ_meshColor(msh,'overlay', t, 'thresh', .01, 'crange', [.001 2], 'cmap', 'autumn')

[~,~,lh]=AFQ_RenderCorticalSurface(msh4)
view(-70,-5);axis off
camlight(lh,'infinite')
set(gca, 'Color', 'none');export_fig('Reading_temporal.png','-r300','-transparent');


f.data = max(t.data,f.data);
msh5 = AFQ_meshColor(msh,'overlay', f, 'thresh', .01, 'crange', [.001 2], 'cmap', 'autumn')

[~,~,lh]=AFQ_RenderCorticalSurface(msh5)
view(-70,-5);axis off
camlight(lh,'infinite')
set(gca, 'Color', 'none');export_fig('Reading_frontal.png','-r300','-transparent');

f.data = f.data+ips.data;
msh6 = AFQ_meshColor(msh,'overlay', f, 'thresh', .01, 'crange', [.001 2], 'cmap', 'autumn')

[~,~,lh]=AFQ_RenderCorticalSurface(msh6)
view(-70,-5);axis off
camlight(lh,'infinite')
set(gca, 'Color', 'none');export_fig('Reading_withIPS.png','-r300','-transparent');

%% Fibers
arc = fgRead('L_Arcuate.pdb')
ilf = fgRead('L_ILF.pdb')
[p,~,lh]=AFQ_RenderCorticalSurface(msh5)
view(-70,-5);axis off
camlight(lh,'infinite')
hold on
AFQ_RenderFibers(arc,'numfibers',500,'color',[0 .5 1],'newfig',0)
AFQ_RenderFibers(ilf,'numfibers',500,'color',[1 .5 0],'newfig',0)
set(p,'facealpha',.1)
set(gca, 'Color', 'none');export_fig('Reading_Fibers.png','-r300','-transparent');


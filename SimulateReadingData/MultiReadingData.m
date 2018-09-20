%% Simulate data and write .eps images

% Random data where y is a weighted sum of x1 and x2
%x1 = zscore(randn(100,1));
%x2 = zscore(randn(100,1));
%y = zscore(.5.*x1 + .5.*x2 + .8.*randn(100,1));
% Add a point for illustration
x1(101) = 1; x2(101) = -2; y(101)=-2;
figure; hold on
for ii = 1:length(y)
    AFQ_RenderEllipsoid(eye(3).*.03,[x1(ii),x2(ii),y(ii)],50,[.5 .5 .5],0,1);
end
axis square
axis equal
axis vis3d
grid
view(0,0);
set(gca,'fontsize',18)
xlabel('Phonological Awareness','fontsize',24);
ylabel('Visual Processing','fontsize',24)
zlabel('Reading Score','fontsize',24);
set(gca,'linewidth',2)
print('ReadPA.eps','-depsc')
view(90,0);
print('ReadVis.eps','-depsc')
view(0,0);

%% Color one point and make the rotating video
vidObj = VideoWriter('Read.avi');
open(vidObj);
writeVideo(vidObj,getframe(gcf));
AFQ_RenderEllipsoid(eye(3).*.04,[x1(101),x2(101),y(101)],50,[.7 0 0],0,1);
writeVideo(vidObj,getframe(gcf));
shading interp
h = camlight('infinite');
writeVideo(vidObj,getframe(gcf));
for ii = 1:90
    view(ii,0)
    h = camlight(h,'infinite');
    pause(.05);drawnow;
    writeVideo(vidObj,getframe(gcf))
end
close(vidObj);
%x1 = randn(100,1)
%x2 = randn(100,1)
%y = .5.*x1 + .5.*x2 + .8.*randn(100,1);
s = 77;
figure; hold on
for ii = 1:length(y)
    if ii ~=s
        AFQ_RenderEllipsoid(eye(3).*.05,[x1(ii),x2(ii),y(ii)],50,[.5 .5 .5],0,1);
    else
        AFQ_RenderEllipsoid(eye(3).*.05,[x1(ii),x2(ii),y(ii)],50,[.7 0 0],0,1);
    end
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
shading interp
h = camlight('infinite');
f(1)=getframe(gcf)
vidObj = VideoWriter('Read.avi');
open(vidObj);
for ii = 1:90
    view(ii,0)
    h = camlight(h,'infinite');
    pause(.05);drawnow;
    writeVideo(vidObj,getframe(gcf))
end
close(vidObj);
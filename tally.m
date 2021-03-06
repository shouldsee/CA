figure(10)
d=table2array(readtable('../data/ratios'));

xs=d(:,1);
ys=d(:,4);
zs=atan(d(:,10));
[xq,yq]=ndgrid(1:.2:30,1:.2:30);
zq=griddata(xs,ys,zs,xq,yq);
scatter3(xs,ys,zs);
xlabel('mod1')
ylabel('mod2')
zlabel('slope angle in radian')
title('strip-vain phase transition')
xlim([0 30])
 hold on 
 mesh(xq,yq,zq)
 hold off
%  %%
%  load carbon12alpha
% f1 = fit(angle, counts, 'nearestinterp')
% f2 = fit(angle, counts, 'pchip')
% p1 = plot(f1, angle, counts)
% xlim( [min(angle), max(angle)])
% hold on
% p2 = plot(f2, 'b')
% hold off
% legend([p1; p2], 'Counts per Angle','Nearest', 'pchip')
tan(-0.8848)
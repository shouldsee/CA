function txt = myupdatefcn(~,event_obj)
% Customizes text of data tips
pos = get(event_obj,'Position');
I = get(event_obj, 'DataIndex');
txt = {['X: ',num2str(pos(1))],...
       ['Y: ',num2str(pos(2))],...
       ['I: ',num2str(I)]};
%        ['T: ',num2str(t(I))]};


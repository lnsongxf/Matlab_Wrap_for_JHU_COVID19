function Make_Map(app)
% Make_Map(app)
% This function makes a map of the JHU infection data for the 
% COVID19_Matlab_App (app).

close all
cla(app.map);

Nt = length(app.dates);
j = round(app.TimeSlider.Value)+Nt;
[h,cblab,ticklabs,K] = pop_out_map(app,j);

copyobj(h.Children, app.map);  % Copy all of the axis' children to app axis
% delete(h.Parent) % get rid of the figure created by worldmap()
% Add colorbar for scale.
colormap(app.map,'jet')
colorbar(app.map,'off')
hcb = colorbar(app.map,'east');
set(get(hcb,'Xlabel'),'String',cblab)
set(hcb,'Ticks',linspace(0,1,length(K)),'TickLabels',ticklabs)
hcb.Position([2,4]) = [0.6,0.3];
if j<=Nt
    app.map.Title.String = ['Map of Pandemic (',app.map_what.Value,') on ',app.dates{j}];
else
    app.map.Title.String = ['Prediction of Pandemic for ',datestr(datenum(app.dates{end},'mm/dd/yyyy')+j-Nt)];
    app.map.Title.String =app.map.Title.String(1:end-5);
end

f = figure(2);
h=gca;
copyobj(app.map.Children,h);
colormap('jet')
hcb2 = colorbar('east');
hcb2.Position([2,4]) = [0.6,0.3];
set(get(hcb2,'Xlabel'),'String',cblab)
set(hcb2,'Ticks',linspace(0,1,length(K)),'TickLabels',ticklabs)
if j<=Nt
    title(['Map of Pandemic (',app.map_what.Value,') on ',app.dates{j}]);
else
    title(['Prediction of Pandemic in ',num2str(j-Nt),' days']);
end
saveas(f,['screenshots/',app.RegionDropDown.Value],'png')


%This function shows the functioning of the Leech Protocol
%--------------------------------------------------------
function [  ] = Leech_0(  )
BINS = showAll('SELECT  *FROM `TRASH_MANAGEMENT`.BIN');
%thresoldDis = input('Enter the Thresold distance to be simulated: ');
location = [5.934, 6.563];
locateMe(location);
showAll_data(BINS);
for i=1:(length(BINS.Xcor)-1)
    %--fprintf('\nMain Loop: %d\n',i);
    BINS = sortData(i, BINS, location);
    location = [BINS.Xcor(i) BINS.Ycor(i)];
    fprintf('\n%d. Location  = [%0.2f %0.2f] & level [%0.2f] \n',i, location(1), location(2), BINS.Level(i));
end




end

%Funtion calculating the distance
%--------------------------------
function [ res ] = FindingDis(x1, y1, x2, y2)
res = sqrt((x2-x1)^2+(y2-y1)^2);
end


%locating the GPS on the Map
%----------------------------
function [ ] = locateMe(location)
figure(2)
plot(location(1),location(2),'Blueh');
text(location(1),location(2),'  GPS cordiantes');
hold on;
grid on;
end

%showing the given data on map
%-----------------------------
function [] = showAll_data(BINS)
for i =1:length(BINS.Xcor)
    plot(BINS.Xcor(i),BINS.Ycor(i),'ro');
    text(BINS.Xcor(i),BINS.Ycor(i),sprintf('  %0.2f%%',BINS.Level(i)));
end
end


%Sorting the data
%----------------
function [BINS] = sortData(n, BINS ,location)
syms ID X Y Lev Dis;

BINS.Dis = updateDis(n, BINS, location);
disp(BINS.Dis);

ID = BINS.ID(n); X = BINS.Xcor(n); Y = BINS.Ycor(n);
Lev = BINS.Level(n);
dis = BINS.Dis(n);
for i = n+1:length(BINS.Xcor)
    if(BINS.Dis(n)>BINS.Dis(i) )
        BINS.ID(n) = BINS.ID(i);
        BINS.Xcor(n) = BINS.Xcor(i); 
        BINS.Ycor(n) = BINS.Ycor(i);
        BINS.Level(n) = BINS.Level(i);
        BINS.Dis(n) = BINS.Dis(i);
            
        BINS.ID(i) = ID; BINS.Xcor(i) = X; 
        BINS.Ycor(i) = Y; BINS.Level(i) = Lev;
        BINS.Dis(i) = dis;
    end
    %--showAlldata(BINS);
end

end




function [dis] = updateDis(n, BINS, location)
%%updating Distance ----------------------------------------

dis = zeros(length(BINS.Xcor), 1);
for i = n:length(BINS.Xcor)
    dis(i) = FindingDis(BINS.Xcor(i), BINS.Ycor(i), location(1), location(2));
end

%------------------------------------------------------------------------------
end


%For printing all required data 
%--------------------------------------
function [] = showAlldata(BINS)
    fprintf('ID  \t  X-cor  \t  Y-cor  \t  Level  \t  Dist.\n\n');
    for i = 1:length(BINS.ID)
        fprintf('%d \t %f \t %f \t %0.2f%% \t %0.2f \n\n',BINS.ID(i), BINS.Xcor(i),...
            BINS.Ycor(i),BINS.Level(i), BINS.Dis(i));
    end
    
end



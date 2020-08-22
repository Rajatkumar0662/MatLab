%This function shows the functioning of the Leech Protocol
%--------------------------------------------------------
function [  ] = Leech_1( BINS )
%BINS = showAll('SELECT  *FROM `TRASH_MANAGEMENT`.BIN');
%thresoldDis = input('Enter the Thresold distance to be simulated: ');
location = [5.934, 6.563];
locateMe(location);%This will print the coordinates on the Maps
fprintf('\n Default Location  = [%0.2f %0.2f] GPS \n\n', location(1), location(2));
for i=1:(length(BINS.Xcor))
    BINS.Dis = FindDis(i, location, BINS);
    showAll_data(BINS);%This will print the coordinates on the Maps
    BINS = sortManually(i, BINS);
    location = [BINS.Xcor(i) BINS.Ycor(i)];
    
    fprintf('\n%d. Location  = [%0.2f %0.2f] & level [%0.2f] \n\n',i, location(1), location(2), BINS.Level(i));
end

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
fprintf('ID  \t  X-cor  \t  Y-cor  \t  Level  \tDistance\n\n');
    for i = 1:length(BINS.ID)
        fprintf('%d \t %f \t %f \t %0.2f%% \t %0.2f \n\n',BINS.ID(i), BINS.Xcor(i),...
            BINS.Ycor(i),BINS.Level(i),BINS.Dis(i));
    end
end


%Finding the distance of the BINS from the GPS
%------------------------------------------------------
function [Distance] = FindDis(n, location, BINS)
x1 = location(1);
y1 = location(2);
Distance = zeros(length(BINS.ID),1);
for i = n:length(BINS.ID)
    x2 = BINS.Xcor(i);
    y2 = BINS.Xcor(i);
    Distance(i) = sqrt((x2-x1)^2+(y2-y1)^2);
    
   
end


end


function [BINS] = sortManually(n, BINS)
syms ID X Y L D;

for i = n+1:length(BINS.ID)
    if(BINS.Dis(n)>BINS.Dis(i))
        %store values in Temp variable
        ID = BINS.ID(n);X = BINS.Xcor(n);Y = BINS.Ycor(n);
        L = BINS.Level(n);D = BINS.Dis(n);
        %Swap data along
        BINS.ID(n) = BINS.ID(i);
        BINS.Xcor(n) = BINS.Xcor(i);
        BINS.Ycor(n) = BINS.Ycor(i);
        BINS.Level(n) = BINS.Level(i);
        BINS.Dis(n) = BINS.Dis(i);
        
        BINS.ID(i) = ID;
        BINS.Xcor(i) = X;
        BINS.Ycor(i) = Y;
        BINS.Level(i) = L;
        BINS.Dis(i) = D;
    end
end

end














%In this section we will generate the main function for
%Trash Management System

%%Algorithm for this simulation
% 1. Display the previous data in the Database.
% 2. Ask if we want to proceed with same data or not
% 3. if 
%       yes then jump to step 7
%    else 
% 4.    Delete previous data
% 5. Ask for number of BINS required in Simulation
% 6. Generate new data in Recursive loop accordingly and Display
% 7. Plot the BINS over the maps
% 8. Get GPS locations of the 'VAN' and 'DISPOSABLE_AREA'
% 9. create distance vector table and sort 
%10. connect each nodes to each other and plot.


%%GPS 
location = [5.934, 6.563];
fprintf('\n\n--- Trash Management System ---\n');
fprintf('\nEntering user interface...\n');
%Display the menu to operate with in a loop
while(1)
    choice = show_Menu;
    switch choice
        case 1
            BINS = showAll('SELECT  *FROM `TRASH_MANAGEMENT`.BIN');
            
        case 2
            t_sold = input('\nThreshold level       ');
            figure(3)
            BINS = showAll(sprintf('SELECT 	*FROM `TRASH_MANAGEMENT`.BIN where level>%d',t_sold));
            for i =1:length(BINS.Xcor)
                hold on;
                grid on;
                plot(BINS.Xcor(i),BINS.Ycor(i),'ro');
                text(BINS.Xcor(i),BINS.Ycor(i),sprintf('  %0.2f%%',BINS.Level(i)));
            end
            clear t_sold;
            
        case 3
            refreshList;
            
        case 4
            if (isempty(BINS)==1)
                fprintf('\nDatabase is not loaded\n');
                load = input('choose 1 to load\n');
                if (load == 1)
                    BINS = showAll('SELECT 	*FROM `TRASH_MANAGEMENT`.BIN');
                end
            else
                x = BINS.Xcor;
                y = BINS.Ycor;
                z = BINS.Level;
                mapList(x,y,z);
            end
            
        case 5
            Leech_1(BINS);
            
        case 6
            clear;
            clc;
            clf;clf(2);clf(3);
            close(figure(1));
            break;
    end
        
end

function [] = refreshList()
deleteAll;
new_Simulation;
end

function [] = mapList(x,y,z)
getGPS;
input('Press Enter to get the BINS locate on Map');

for i =1:length(x)
    plot(x(i),y(i),'ro');
    text(x(i),y(i),sprintf('  %0.2f%%',z(i)));
end
end

function [location] = getGPS()
figure(1),clf;
input('Press Enter to get GPS location');
fprintf('\nGetting GPS Location.....   \n');
location = [5.934, 6.563];
disp(location);
plot(location(1),location(2),'Blueh');
text(location(1),location(2),'  GPS cordiantes');
title('Bin representation in MAP');
xlabel('X-cordinates'),ylabel('Y-cordinates');
hold on;
grid on;
end

%optional - Framework*





%In this section we will generate the main function for
%Trash Management System
%%Algorithm for this simulation
% 1. Display the previous data in the Database.
% 2. Ask if we want to proceed with same data or not
% 3. if 
%       yes then jump to step 7
%    else 
% 4.    Delete previous data
% 5. Ask for number of Bins required in Simulation
% 6. Generate new data in Recursive loop accordingly and Display
% 7. Plot the bins over the maps
% 8. Get GPS locations of the 'VAN' and 'DISPOSABLE_AREA'
% 9. create distance vector table and sort 
%10. connect each nodes to each other and plot.




%%Setting up connections to the Database
%Set preferences with setdbprefs(Here all to default or NULL values).
setdbprefs('DataReturnFormat', 'structure');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
fprintf('Connecting to database "TRASH_MANAGEMENT"\n\n');
conn = database('TRASH_MANAGEMENT', 'root', 'qwertyuiop', 'Vendor',...
    'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);

%%1. Displaying the previous data
% for that we need to read and load data from database to workspace

%Read data from database by creating the cursor/pointor to the connection
curs = exec(conn, 'SELECT 	*FROM `TRASH_MANAGEMENT`.BIN');
level = input('Enter the thresold level of the Bin\n');
%filtered_Data = exec(conn, 'SELECT 	*FROM `TRASH_MANAGEMENT`.BIN where level>%d',level);
clear level;
curs = fetch(curs);
close(curs);
fprintf('\n\nFetching data from the Database......\n\n');
%Assign data to output variable
BINS = curs.Data;
%f_BINS = filtered_Data.Data;
close(conn);
msg = 'No Data';
clear conn curs filtered_Data;
if (strcmp(BINS,msg)==1)
    fprintf('\nThere is no previous Data found\n');
else
    %loading data to workspace
    fprintf('\nData found in database till now\n\n');
    fprintf('ID  \t  X-cor  \t  Y-cor  \t  Level\n\n');
    for i = 1:length(BINS.ID)
        fprintf('%d \t %f \t %f \t %0.2f%% \n\n',BINS.ID(i),BINS.Xcor(i),...
            BINS.Ycor(i),BINS.Level(i));
    end
    
    %%2. option for using previous or new data
    
    fprintf('\nWould you like refresh data recieved\n');
    option = input('1. Yes\n2. No\n');
    
    
    if (option == 2)
        getGPS;
        input('Press Enter to get the bins locate on Map');
        for i =1:length(BINS.ID)
            plot(BINS.Xcor(i),BINS.Ycor(i),'ro');
            
        end
        
    else
        deleteAll;
        new_Simulation;
    end
    

end





function [] = getGPS()
figure(1),clf;
title('Bin representation in MAP');
xlabel('X-cordinates'),ylabel('Y-cordinates');
input('Press Enter to get GPS location');
fprintf('\nGetting GPS Location.....   \n');
location = round([rand*100,rand*100],4);
disp(location);
plot(location(1),location(2),'Blueh');
text(location(1),location(2),'  GPS cordiantes');
hold on;
grid on;
end



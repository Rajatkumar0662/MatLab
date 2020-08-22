function [BINS] = showAll(msg)

fprintf('\nConnecting to the Databases...\n');
syms ID x y Dis;


%%Setting up connections to the Database
%Set preferences with setdbprefs(Here all to default or NULL values).
setdbprefs('DataReturnFormat', 'structure');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
fprintf('\nConnecting to database "TRASH_MANAGEMENT"\n\n');
conn = database('TRASH_MANAGEMENT', 'root', 'qwertyuiop', 'Vendor',...
    'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);
%Read data from database by creating the cursor/pointor to the connection
curs = exec(conn, msg);
curs = fetch(curs);
close(curs);
fprintf('\n\nFetching data from the Database......\n\n');
%Assign data to output variable
BINS = curs.Data;
%close(conn);
%clear conn curs;

%%ERROR MESSAGE
msg = 'No Data';
if (strcmp(BINS,msg)==1)
    fprintf('\nThere is no Data found\n');
    option = input('\nWant to create new data entries\n');
    if(option == 1)
        new_Simulation;
    end
    
else
    %loading data to workspace
    fprintf('\nData found in database till now\n\n');
    fprintf('ID  \t  X-cor  \t  Y-cor  \t  Level\n\n');
    for i = 1:length(BINS.ID)
        fprintf('%d \t %f \t %f \t %0.2f%% \n\n',BINS.ID(i), BINS.Xcor(i),...
            BINS.Ycor(i),BINS.Level(i));
    end
    
end

end

%optional Framework**



%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'structure');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('TRASH_MANAGEMENT', 'root', 'qwertyuiop', 'Vendor', 'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);

%Read data from database.
curs = exec(conn, ['SELECT 	BIN.ID'...
    ' ,	BIN.Xcor'...
    ' ,	BIN.Ycor'...
    ' FROM 	`TRASH_MANAGEMENT`.BIN ']);


curs = fetch(curs);
close(curs);

%Assign data to output variable
BINS = curs.Data;
%% will create all our logics here to implement the data in the simulation
for i = 1:length(BINS.ID)
    lfprintf('%d\t%f\t%f\n',BINS.ID(i),BINS.Xcor(i),BINS.Ycor(i));
end



%Close database connection.
close(conn);

%Clear variables
clear curs conn
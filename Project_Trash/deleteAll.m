function [  ] = deleteAll(  )
%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('TRASH_MANAGEMENT', 'root', 'qwertyuiop', 'Vendor',...
    'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);

%%1. Displaying the previous data
% for that we need to read and load data from database to workspace

%Read data from database by creating the cursor/pointor to the connection
curs = exec(conn, 'DELETE 	FROM     `TRASH_MANAGEMENT`.BIN ');

curs = fetch(curs);
close(curs);
fprintf('All previous Data have been deleted\n');

end


function [  ] = new_Simulation(  )
%in this new simulation new data will be added to the database.
n = input('Enter the number of Bins to be added in the Simulation\n');
name = 'bin';
%%opening connection
conn = database('TRASH_MANAGEMENT', 'root', 'qwertyuiop', 'Vendor',...
    'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);

for i = 1:n
    index = i;
    Xcor = rand*100;
    Ycor = rand*100;
    level = round(20+(100-20).*rand,2);
    datainsert(conn,name,{'ID','Xcor','Ycor','Level'},[index, Xcor,...
        Ycor, level]);
end
fprintf('%d Data entries are created\n\n',i);
close (conn)
clear conn;
clc;
end


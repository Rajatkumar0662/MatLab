function [ choice ] = show_Menu( )
syms choice;
fprintf('\n\nOptions\n');
fprintf('1. Show all data entries\n');
fprintf('2. List out Threshold entries\n');
fprintf('3. Refresh Entries\n');
fprintf('4. Show on Map\n');
fprintf('5. Optimized Routing\n');
fprintf('6. Exit\n');
choice=input('\nEnter your choice from above...       ');
end


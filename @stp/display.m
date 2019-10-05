function display(a)
% STP/DISPLAY    display method for stp class

% $Id: display.m 7 2010-04-09 12:11:31Z hsqi $

disp(' ');
disp([inputname(1),' =']);
disp(' ');
if isempty(a.c)
	disp('     []');
else
	disp(a.c);
end
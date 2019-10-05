function display(obj)
% LM/DISPALY    display method for lm class

% $Id: display.m 11 2010-12-25 16:01:05Z hsqi $

disp(' ');
disp([inputname(1),'=']);
disp(' ');
l = length(obj.v);
if l > 256
	disp(['    v: [1x' num2str(l) ' integer]']);
else
	disp(['    v: [' sprintf(' %d ', obj.v) ']']);
end
disp(['    n: ' num2str(obj.n)]);
disp(' ');
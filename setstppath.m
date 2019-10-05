function r = setstppath(i)
% SETSTPPATH    Add/Remove/Check STP toolbox dir in the Matlab path
%
%   SETSETPATH    checks whether the STP toolbox directory is in the Matlab path.
%   SETSETPATH(1) will add the STP toolbox directory to the beginning of Matlab path.
%   SETSETPATH(0) will remove the STP toolbox directory from the Matlab path.

% $Id: setstppath.m 15 2013-01-14 16:51:38Z hsqi $

chkpath = 0;
if nargin == 0 & nargout == 0
	chkpath = 1;
end

themfilepath = mfilename('fullpath'); % get the full path and file name of this m file 
pos = findstr(themfilepath,filesep);
stp_path = themfilepath(1:(pos(end)-1)); % get the stp path and exclude the file separator at the end

matlab_path = path; % get all the search path of matlab

in_path = 0;
while any(matlab_path)
	[chopped,matlab_path] = strtok(matlab_path,pathsep);
	in_path = strcmp(chopped,stp_path);
	if in_path
		break;
	end
end

if chkpath == 1
	if in_path
		fprintf('STP toolbox dir ''%s'' is in the Matlab path, \nyou may use ''setstppath(0)'' to remove it.\n', stp_path);
	else
		fprintf('STP toolbox dir ''%s'' is not in the Matlab path, \nyou may use ''setstppath(1)'' to add it.\n', stp_path);
	end
else
	if i == 1
		if ~in_path
			eval(sprintf('addpath ''%s''',stp_path))
			if nargout == 0
				fprintf('STP toolbox dir ''%s'' has been added to the Matlab path\n',stp_path)
			else
				r = 1;
			end
		else
			%~ warning(sprintf('STP toolbox dir ''%s'' is already in the Matlab path\n',stp_path))
			r = 1;
		end
	elseif i == 0
		if in_path
			eval(sprintf('rmpath ''%s''',stp_path))
			if nargout == 0
				fprintf('STP toolbox dir ''%s'' has been removed from the Matlab path\n',stp_path)
			else
				r = 1;
			end
		else
			%~ warning(sprintf('STP toolbox dir ''%s'' is not in the Matlab path.\n',stp_path))
			r = 1;
		end
	else
		error(sprintf('The input argument must be 1 or 0.\nPlease use ''setstppath(1)'' to add the STP toolbox dir to the Matlab path, and \nuse ''setstppath(0)'' to remove the STP toolbox dir from the Matlab path.\n'))
	end
end
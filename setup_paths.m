function setup_paths()
% Add this repository's function folders to the MATLAB path.
% Run this once before executing scripts in scripts/ or fingerprinting/.

root = fileparts(mfilename('fullpath'));
addpath(fullfile(root, 'functions'));
addpath(fullfile(root, 'fingerprinting', 'functions'));

end

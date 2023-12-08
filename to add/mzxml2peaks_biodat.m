function [P,T] = mzxml2peaks_biodat(bio_dat,varargin)
% MZXML2PEAKS converts a mzXML struct to a list of peaks.
%
%   [P,T] = MZXML2PEAKS(MZXMLSTRUCT) extracts peak information from an
%   mzXML structure. P is a cell with peak lists, a peak list is a 2 column
%   matrix with the mass/charge (MZ) and ion intensity for every peak. T is
%   a vector with the retention time of every scan.
%
%   MZXML2PEAKS(...,LEVELS,L) specifies the level(s) of the spectra to
%   convert, assuming the spectra are from tandem MS data sets. Default is
%   1, which converts only the first level spectra, which are spectra
%   containing precursor ions. Setting L to 2, converts only the second
%   level spectra, which are the fragment spectra (created from a
%   precursor ion). L can also be a vector with all the levels to include.
%
%   Example:
%
%       % Extract the peak information of only the first level ions from
%       % the file results.mzxml and create a dotplot:
%       mzxml_struct = mzxmlread('results.mzxml');
%       [peaks,time] = mzxml2peaks(mzxml_struct);
%       msdotplot(peaks,time)
%
%   Note that the file results.mzxml is not provided. Sample files can be
%   found at http://sashimi.sourceforge.net/repository.html.
%
%   See also MSPALIGN, MSDOTPLOT, MSPPRESAMPLE,
%   MZXMLINFO, MZXMLREAD.

%   Copyright 2006-2019 The MathWorks, Inc.


% check inputs
if nargin > 1
    [varargin{:}] = convertStringsToChars(varargin{:});
end

bioinfochecknargin(nargin,1,mfilename);
% handle options
L = parse_inputs(varargin{:});

PC = arrayfun(@(x) x.peaksCount,bio_dat);
level = arrayfun(@(x) x.msLevel,bio_dat);

h = find(PC&ismember(level,L));
n = numel(h);

P = cell(n,1);
T = zeros(n,1);

for i =1:n
    i
    % T(i) = sscanf(bio_dat(h(i)).retentionTime,'PT%f');
    P{i} = reshape(bio_dat(h(i)).peaks.mz,2,PC(h(i)))';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [L] = parse_inputs(varargin)

% Check that we have the right number of inputs
if rem(nargin,2)== 1
    error(message('bioinfo:mzxml2peaks:IncorrectNumberOfArguments', mfilename));
end

% The allowed inputs
okargs = {'levels'};
% Set default values
L = 1;

% Loop over the values
for j=1:2:nargin
    % Lookup the pair
    [k, pval] = bioinfoprivate.pvpair(varargin{j}, varargin{j+1}, okargs, mfilename);
    switch(k)
        case 1 % levels
            if ~isnumeric(pval) || ~isvector(pval)
                error(message('bioinfo:mzxml2peaks:badLevels'))
            end
            L = pval(:);
    end
end
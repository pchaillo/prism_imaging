% Modified version of the code below to support MatLab's later releases
% ===========================================================
% File: createParallelProgressBar.m
% Description: This file defines the createParallelProgressBar parfor
%              progress bar function.
% ===========================================================
% Blog Post: How to Add a Progress Bar for Matlab parfor Loops
% Post link: https://vladislav-morozov.github.io/blog/simulations/tools/...
%            2024-11-11-simple-parfor-progress-bar/
% Author: Vladislav Morozov
% Date: 2024-11-11
% License: MIT
% ===========================================================

function queue = createParallelProgressBar(totalIterations)
    % createParallelProgressBar Initializes a progress bar for parallel
    % computations with dynamic color changing from dark orange to blue.
    %
    % Args:
    %     totalIterations (int): Total number of iterations for the
    %                            progress bar.
    %
    % Returns:
    %     queue (parallel.pool.DataQueue): DataQueue to receive progress
    %                                      updates.
    %
    % Example usage in a parallel loop:
    %     numSamples = 100;
    %     % Create progress bar
    %     queue = createParallelProgressBar(numSamples);
    %     parfor i = 1:numSamples
    %         % Simulate computation
    %         pause(0.1);
    %         % Update progress bar
    %         send(queue, i);
    %     end

    % Initialize DataQueue and Progress Bar
    queue = parallel.pool.DataQueue;
    progressBar = waitbar(0, 'Processing...', 'mzML Bulk Conversion', 'Conversion Progress');
    

    % Reset persistent variable count
    persistent count
    count = 0;

    % Nested function to update progress and color
    function updateProgress(~)
        count = count + 1;
        shareComplete = count / totalIterations;
        
        % Update waitbar position
        waitbar(shareComplete, progressBar);

        % Close progress bar when complete
        if count == totalIterations
            close(progressBar);
            count = [];
        end
    end

    % Add listener to the DataQueue
    afterEach(queue, @updateProgress);
end
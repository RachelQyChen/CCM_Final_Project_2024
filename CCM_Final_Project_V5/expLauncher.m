%%%CCM Final Project%%%
%%%Function created by Rachel Chen (qc898@nyu.edu)%%%
%%%Created date: Apr 27th, 2024%%%

%%%Version 4 updated by Rachel Chen (qc898@nyu.edu)%%%
%%%Last Updated: Apr 29th, 2024%%%

%%%Version 3 updated by Helen Hu (fh986@nyu.edu)%%%
%%%Last Updated: Apr 29th, 2024%%%

%%%----------------------------------------------------%%%
%%%            Aim: Blue judgement task%%%
%%%----------------------------------------------------%%%

%% Experimental Procedure
%Part 0: check if it testing remotly
%Part 1: create personalize stimuli color bricks

%% Initialization
clear all; clc; close all;

%% Part 0: Ask if this is a remote task
isRemote = input('Enter 1 for remote test, 2 for local test: ');

%Determine the course of action based on the test type
if isRemote == 1
    fprintf('Remote testing selected.\n');
    blueColorExperimentRemote
elseif isRemote == 2
    fprintf('Proceeding with local testing.\n');
    blueColorExperiment
end

%% Part 1:Compare in paris
compareAdjacentGValues

%% Close all
clear all; clc; close all;


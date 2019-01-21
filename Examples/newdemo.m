% with last 7 days
if exist('r')
    r.kill
end
clear all;
addpath('..\..\MatlabR-master');
%% begin establish r connection
r=MatR();
if ~r.isConnected
    r.connect
end
%% demo use 
xx=[1 2;3 4];
r.assign('xx',xx);
r.eval('xx*2');
yy=r.result.asDoubleMatrix();
%% end
r.kill;
clear r;
%% test another begin
r=MatR();
if ~r.isConnected
    r.connect
end
%% test another end 
r.kill;
clear r;






function [ frequency,time ] = getNMaxValues( vector,N,FS )
%   getNMaxValues
%
%   This function will get the N peak values of a sound wave vector and return
% the time it happened as a vector.
%   As the frequency is high, when I get a peak, I set the previous 1000
% and the next 1000 values of this peak to zero.

% Mauricio Avanzi Françoso
% Federal University of ABC Undergrad Student
% 2017

%% initialize time vector
[row,~]=size(vector);
frequency=NaN(N,1);


%% get the peak value
% get the peak value and set the previous and next 1000 values to zero

for i=1:N
    M=max(vector(:,1));
    for j=1:row
        if vector(j,1) == M
            for k=j-1000:j+1000
                vector(k,1)=0;
            end
            frequency(i,1)=j;
        end
    end

end


%% sort time
% sort time vector and exclude the last peak because in one case I was
% getting some trouble


frequency = sort(frequency);
time=NaN(N-1,1);

frequency=frequency(1:end-1);
for i=1:N-1
    time(i,1)=frequency(i,1)/FS;
end


end


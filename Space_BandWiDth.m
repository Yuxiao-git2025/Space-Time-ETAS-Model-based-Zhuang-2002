function BWD=Space_BandWiDth(lon,lat,np,B0)
if nargin<2 || isempty(B0)
    B0=0.01; end

N=length(lon);  NN=length(lat);
if NN ~= N
    error(' Input Error !!'); end
if np < 1 || np > N
    error('Try a smaller np'); end
BWD=zeros(N,1);
for i = 1:N
    % Loops each event
    dist = sqrt((lon(i)-lon).^2 + (lat(i)-lat).^2);
    dist(i) = 1e4;  % Excluded itself
    % Find the np.th event
    inp = sort(dist);
    BWD(i) = inp(np);
    if BWD(i)<B0
        BWD(i)=B0;
    end
end
end
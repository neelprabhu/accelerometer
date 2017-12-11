% BME 271 Fall 2017
% Tremor Reduction for Microsurgical Applications
% interpolator: Interpolates if insufficient samples in human

function human = interpolator(human,xpath)

discrep = size(human,1)-length(xpath);
if discrep < 0
    r     = randi(length(human(:,1))-1,[1 abs(discrep)]);
    for i = 1:length(r)
        if r(i) == 1
           r(i) = 2;
        end
        xinterp = (human(r(i)-1,1) + human(r(i) + 1,1))./2;
        yinterp = (human(r(i)-1,2) + human(r(i) + 1,2))./2;
        interp  = [xinterp yinterp];
        human   = [human(1:r(i),:); interp; human((r(i)+1):end,:)];
    end  
else
    human = [human((discrep+1):end,1) human((discrep+1):end,2)];
end

end
function E = edgeLink(M, J, theta1)
E=M;
med_grad=median(J(:));
max_val=max(J(:));

% Setting global thresholds for hystersis
if med_grad>5
    low_thres=1.5*med_grad;
    high_thres=1.66*med_grad;
else
    high_thres=int8((max_val/10))*10;
    if med_grad<1
        low_thres=4*med_grad;
    else
        low_thres=7;
    end
end

% Discarding pixels lower than low threshold
E(J < low_thres)=0; 
M(J < low_thres)=0;
% Edge points
E(J >= high_thres)=1;
M(J >= high_thres)=1;

figure;
imshow(E);

% Checking for weak edge points
for i=2:size(theta1,1)-1
    for j=2:size(theta1,2)-1
      if(M(i,j)==1)
         angle=theta1(i,j);
         if (J(i,j)>=low_thres && J(i,j)<high_thres)
            if angle>=0 && angle<45
                E(i+1,j)=1;
                E(i-1,j)=1;             
            elseif angle>=45 && angle<90
                E(i+1,j-1)=1;
                E(i-1,j+1)=1;
            elseif angle>=90 && angle<135
                E(i,j-1)=1;
                E(i,j+1)=1; 
            else
                E(i-1,j-1)=1;
                E(i+1,j+1)=1;              
            end
         end
      end
    end
end
E=bwmorph(E,'thin');
E=bwmorph(E,'skel');
E=bwmorph(E,'clean');
E=logical(E);
end


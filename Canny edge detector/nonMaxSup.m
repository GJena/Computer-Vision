function M = nonMaxSup(J, theta1)
M=zeros(size(J));

for i=2:size(J,1)-1
    for j=2:size(J,2)-1
        x=theta1(i,j);
        y=J(i,j);
        %finding perpendicular points
        if(x>=0&&x<45)
            x1=0;
            y1=J(i,j+1);
            y2=J(i-1,j+1);
            y3=J(i,j-1);
            y4=J(i+1,j-1);         
        elseif(x>=45&&x<90)
            x1=45;
            y1=J(i-1,j);
            y2=J(i-1,j+1);
            y3=J(i+1,j);
            y4=J(i+1,j-1);               
        elseif(x>=90&&x<135)
            x1=90;
            y1=J(i-1,j-1);
            y2=J(i-1,j);
            y3=J(i+1,j);
            y4=J(i+1,j+1);            
        else
            x1=135;
            y1=J(i,j-1);
            y2=J(i-1,j-1);
            y3=J(i,j+1);
            y4=J(i+1,j+1);            
        end
        %interpolating the values
        u=(((x-x1)*(y2-y1))/45)+y1;
        v=(((x-x1)*(y4-y3))/45)+y3; 
        %finding the maxima
        max_grad=max(max(v,u),y);

          if max_grad==y 
            M(i,j)=1;  %supressing non-maxima
          end
    end
end
M=logical(M);
end


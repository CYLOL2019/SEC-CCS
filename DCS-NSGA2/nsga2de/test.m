intersect(find(df(301:400,1)>df(201,1)),find(df(301:400,2)>df(201,2)))
%for j = 1 :100
%figure(j);
%hold on;
%for i = 1 :100
%    plot(df((j-1)*100+i,1),df((j-1)*100+i,2),'x');
%end
%pause;
%end
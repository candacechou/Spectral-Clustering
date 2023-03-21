clc;clear all;close all;
sigma=1;%%%human specified parameter
k=4;%%%clustering
%%data=scanf(fid,'%g')
%fclose(fid)
%%%%STEP 1 %%%%
filename = './data/example1.dat';
fid = importdata(filename,'r');
fid_1 = split(fid,",");
fid_1 = cellfun(@str2num,fid_1);
size_1= max(max(fid_1(:,1),fid_1(:,2)));
A=[];
% for i=1:length(fid_1(:,1))
%     if fid_1(i,1) == fid_1(i,2)
%         A(fid_1(i,1),fid_1(i,2))=0;
%     else
%         A(fid_1(i,1),fid_1(i,2))=exp(-abs(fid_1(i,1)-fid_1(i,2))^2/(2*sigma^2));
%     end
% end
for i=1:length(fid_1(:,1))
    for j=1:length(fid_1(:,1))
    if i == j
        A(i,j) = 0;
    else
        A(i,j)=exp(-((fid_1(i,1)-fid_1(j,1))^2+(fid_1(i,2)-fid_1(j,2))^2)^(0.5)/(2*sigma^2));
    end
    end
end

%%%%STEP2%%%%
D = diag(sum(A,2));
L = D^(-1/2)*A*D^(-1/2);
%%%%STEP3%%%%

[X,v]=eigs(L,k);
X_diag=sort(diag(X));

%%%%STEP4%%%%

Y = X./sqrt(sum(X.^2,2));

%%%%STEP5%%%%

[idx,C]=kmeans(Y,k);
color = {'k','b','r','y','m','g','c'};

%%%%PLOT%%%%%
figure
hold on
for i=1:length(fid_1(:,1))
    c=idx(i,1);
    plot(fid_1(i,1),fid_1(i,2),'color',color{c},'marker','x')
end
axis([0 size_1 0 size_1])
strtitle = ['data is ',filename,'with k = ' , int2str(k) ,',sigma = ' , int2str(sigma)];
title(strtitle);
hold off
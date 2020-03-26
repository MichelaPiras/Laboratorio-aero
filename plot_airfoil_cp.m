clear

filename       = 'data/NACA 0012.dat';
delimiterIn    = ' ';
headerlinesIn  = 1;
format long;

airfoil_struct = importdata(filename,delimiterIn,headerlinesIn);

fields = fieldnames(airfoil_struct);
coord  = char(fields(1));

airfoil_coord = airfoil_struct.(coord);

figure(1);
plot(airfoil_coord(:,1),airfoil_coord(:,2),'.','MarkerSize',20);

axis equal;
hold off;

%to see how many cp-distributions are collected (only cp distrinutions file
%can be .txt)

num= dir ('*/*.txt');
n_iter=length(num);

for k=1:n_iter

%to import cp
filename       = strcat('data/',num(k).name);
delimiterIn    = ' ';
headerlinesIn  = 6;
format long;

analysis_struct = importdata(filename,delimiterIn,headerlinesIn);

fields = fieldnames(analysis_struct);
analysis  = char(fields(1));

airfoil_analysis = analysis_struct.(analysis);

figure(2);
plot(airfoil_analysis(:,1),airfoil_analysis(:,2),'g.','MarkerSize',20);

cp=airfoil_analysis(:,2);


hold on
set(gca, 'YDir','reverse');
% axis equal;
hold off


%coordinates
x=airfoil_coord(:,1);
y=airfoil_coord(:,2);


%if more than 3 numbers are extracted
%note that - cutting 85*s-you have axb cell 
%so put a*s

filename= strcat('data/',num(k).name);
fileID = fopen(filename);
C= textscan(fileID,'%*53c %3c 85*s')
fclose(fileID);
alpha(k)=str2num(C{1})*pi/180 %angle of attack, rad


%to determine cl and make a cl-alpha plot
npunti=length(x);
Np=npunti-1;


for i=1:Np
    deltax=x(i+1)-x(i);
    deltay=y(i+1)-y(i);
    deltal=sqrt(deltax^2+deltay^2);
    clp(i)=(cp(i)*(deltax));
    cdp(i)=(cp(i)*(deltay));
    
end
cl(k)=sum(clp);
cd(k)=sum(cdp);


figure(3)
plot(alpha(:),cl(:),'r-')
xlabel('alpha deg')
ylabel('cl')
end







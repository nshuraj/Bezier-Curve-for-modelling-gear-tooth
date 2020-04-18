function g = geartoothformula()
%The parameters of gear
grid on
hold on;
box on;
nn=10;			%The number of teeth
pd=6;			%The diametral pitch
phi_d=20;	%The pressure angle in degrees
% ----------------------------------------------------------------------------
r_fillet=0.05;		                 %The radius of fillet

                                     %To declare variables
xp=zeros(10,1);yp=zeros(10,1);
xo=zeros(5,1);yo=zeros(5,1);
xr=zeros(3,1);yr=zeros(3,1);
xro=zeros(5,1);yro=zeros(5,1);
xf=zeros(5,1);yf=zeros(5,1);
theta=zeros(10,1);
f=zeros(2,28);
M=[];c=[];e=[];g=[];h=[];
% ----------------------------------------------------------------------------
                                             %To calculate the basic parameters of a gear
d=nn/pd;				%pitch diamter
phi=phi_d*pi/180;	%pressure angle in radians
db=d*cos(phi);		%diameter of base circle
do=d+2/pd;			%addendum (outside) diameter
tt=pi/(2*pd);		%tooth thickness at the pitch circle
dr=d-2*1.25/pd;	%dedendum (root) diameter

% ----------------------------------------------------------------------------
                                              %To calculate the coordinates of the involute profile
n1=10;
tp=pi*d/(2*nn);
for i=1:n1;
    r=do/2-(do-db)*(i-1)/(2*(n1-1));
    pha=acos(db/(2*r));
    t=2*r*(tp/d+(tan(phi)-phi)-(tan(pha)-pha));	%tooth tickness at any angle phi
    %involute equation -
    
    theta(i)=t/(2*r);
    xp(i)=r*sin(theta(i));		%change from polar coordinates to cartesian coordinates
    yp(i)=r*cos(theta(i));
end
xp=xp';
yp=yp';
% ----------------------------------------------------------------------------
                                %To calculate the addendum circle
n2=5;
for i=1:n2;
    theta_o=theta(1)*(i-1)/(n2-1);
    xo(i)=(do/2)*sin(theta_o);
    yo(i)=(do/2)*cos(theta_o);
end
xo=xo';yo=yo';
% ----------------------------------------------------------------------------
                                %To calculate the non-involute portion of the curve- between the base circle and
                            % dedendum circle - in this case, a straight line parallel to the y axis and connects
                             % to the fillet arc
for i=1:3;
    theta0=asin((xp(1,n1)+r_fillet)/(dr/2));
    %to find the angle between the central line (y-axis) and the line from the center
    %to the last point of the involute curve.
    xr(i)=xp(1,10);
    yr(i)=yp(1,10)-(yp(1,10)-r_fillet-(dr/2)*cos(theta0))*i/3;
end
xr=xr';yr=yr';
% ----------------------------------------------------------------------------
                                    %To calculate the dedendum circle
n3=5;
for i=1:n3;
    thetar=theta0+(pi/nn-theta0)*(i-1)/(n3-1);
                                              %(pi/n-theta0) angle subtended for dedendeum arc
    xro(i)=dr*sin(thetar)/2;	
    yro(i)=dr*cos(thetar)/2;
end
xro=xro';yro=yro';
% ----------------------------------------------------------------------------
                                               %To calculate fillet
                                 % to draw the quarter of a circle from the last point of the non-involute part to
                                 % the tangent of the dedenum circle.
n4=5;
for i=1:n4;
    xf(i)=xro(1)-r_fillet*cos((i-1)*pi/(2*n4-2));
    yf(i)=yro(1)+r_fillet*(1-sin((i-1)*pi/(2*n4-2)));	
end
xf=xf';yf=yf';
% ----------------------------------------------------------------------------
                                       %To draw each piece of curve to generate half of tooth profile
c=[c,xo,xp,xr,xf,xro];
e=[e,yo,yp,yr,yf,yro];
g=[c',e'];
g=g';						%the half  tooth profile

subplot(2,1,1);


plot (g(1,:),g(2,:),'-r',xp,yp,'-r', 'linewidth',4) 
hold on 
plot (-g(1,:),g(2,:),'-r',-xp,yp,'-r', 'linewidth',4)  %mirror about y axis
axis('equal')
M=M';						
title(['Involute gear tooth profile']);
grid on
end
 
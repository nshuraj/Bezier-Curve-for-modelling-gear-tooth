clc;
clear all;
close all;
grid on
%     n= input('enter the number of polygon points')
% n=26;
p1 = geartoothformula()
p = p1';
n = length(p(:,1));
order= input('Enter order of the curve = ');
%  order=6;


% close all;
% if (nargin ~= 2)
% 	order = 4;
% end
% nplot = 100;

if (n < order)
	display([' !!! Error: Choose n >= order=',num2str(order),' !!!']);
	return;
end

figure(1);
hold on; 
box on;
% set(gca,'Fontsize',16);



% for i = 1:n	
% 	title(['Choose ',num2str(i),' th. control point']);
% 	p(i,:) = ginput(1);
% [p]=[0 1;0.0122437104821155 0.999925042967537;0.0244855854598228 0.999700183107260;0.0367237897038818 0.999325454128826;0.0489564885353467 0.998800912209379;0.0660553887942710 0.973659359111415;0.0814494386382887 0.948303525929976;0.0950971482446366 0.922805348657478;0.106945410544631 0.897238715975652;0.116921870471489 0.871680692715183;0.124920475255524 0.846213928431441;0.130769776486828 0.820932062796417;0.134143062124226 0.795955236060030;0.134013817771142 0.771524576879688;0.134013817771142 0.730115442809939;0.134013817771142 0.688706308740189;0.134013817771142 0.647297174670439;0.134013817771142 0.647297174670439;0.137819841145577 0.628163003052185;0.148658478711814 0.611941835611112;0.164879646152887 0.601103198044875;0.184013817771142 0.597297174670439;0.184013817771142 0.597297174670439;0.186298395141842 0.596588558361266;0.188580243825483 0.595871203901247;0.190859330400139 0.595145121797373;0.193135621484342 0.594410322684471]
% 	p = (geartoothformula())';
%     hold off;
	subplot(2,1,2);
    plot(p(:,1),p(:,2),'b','LineWidth',2);
    hold on
    plot(-p(:,1),p(:,2),'b','LineWidth',2);
    hold on;
%     
%     
% 	axis([0 100 0 100]);
    grid on
	hold on; box on;
    
    axis([-.7 .7 .58 1]);
    hold on;
	T = linspace(0,1,n-order+2);
		y = linspace(0,1,1000);
		p_spl = knots(T,p,y,order);
		plot(p_spl(:,1),p_spl(:,2),'g-','LineWidth',1);
        hold on
        plot(-p_spl(:,1),p_spl(:,2),'g-','LineWidth',1);
        grid on
hold on


title(['Gear tooth profile with B-Spline-curve ']);
% figure
% 	plot(p_spl(:,1),p_spl(:,2),'g-');
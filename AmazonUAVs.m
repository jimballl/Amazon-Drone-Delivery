%Jasper Kimball's Matlab AmazonUAV program

%Using the positions of 3 randomly generated UAVs in a 15 by 15 mile space,
%this script will determine a centerpoint between the 3 UAVs using matrix
%math and then find the radius between the UAVs and this center point. From
%there, we will plot a circle connecting the three UAVs and determine how
%long it will take the UAVs to reach the center of the circle.

clear,clc, format bank, clf %clf clears the figure for next run
fprintf('Jasper Kimball, \nAmazon UAV Delivery Solution')
rng('shuffle') %sets the current time as the random number seed

uavs= randi([1 15], 3, 2); %creates random digits from 1-15 for the three UAVs on different rows
fprintf('\n\nUAV #1 random coordinates (x1,y1):(%i,%i) \nUAV #2 random coordinates (x2,y2):(%i,%i) \nUAV #3 random coordinates (x3,y3):(%i,%i)', uavs(1,1), uavs(1,2),uavs(2,1), uavs(2,2), uavs(3,1),uavs(3,2)) %prints out each UAV's location to the user
A= [(uavs(1,1)-uavs(2,1)), (uavs(1,2)-uavs(2,2));(uavs(2,1)-uavs(3,1)), (uavs(2,2)-uavs(3,2))]; %creates a 2x2 matrix called A
A= A*2; %multiplies A by 2 for matrix math purposes

while( determinant(A) == 0) %sees if the determinant of the A matrix is zero. If not, we must find a new random set of UAVs and test again if determinant is not equal to zero.
    fprintf('\n\ndeterminant =0, no inverse, no solution possible, Deploy UAVs again!')
     uavs= randi([1 15], 3, 2);
    A= [(uavs(1,1)-uavs(2,1)), (uavs(1,2)-uavs(2,2));(uavs(2,1)-uavs(3,1)), (uavs(2,2)-uavs(3,2))]; %resets A
    A= A*2;
     fprintf('\n\nNew Coordinates: UAV #1 random coordinates (x1,y1):(%i,%i) \nUAV #2 random coordinates (x2,y2):(%i,%i) \nUAV #3 random coordinates (x3,y3):(%i,%i)', uavs(1,1), uavs(1,2),uavs(2,1), uavs(2,2), uavs(3,1),uavs(3,2))%tells the user the coordinates of the newly generated UAVs
end
B=[(uavs(1,1)^2+uavs(1,2)^2)-(uavs(2,1)^2+uavs(2,2)^2);(uavs(2,1)^2+uavs(2,2)^2) - (uavs(3,1)^2+uavs(3,2)^2)]; % creates 2x1 matrix called 

X= inv(A)*B;%finds the center of the circle using matrix math to create a 2x1 matrix

if(abs(X(1)) >15 | abs(X(2)) >15) %sees if the airship locations outside the 15 by 15 figure
fprintf('\n\nAirship location (%-5.2f,%-5.2f). Warning! Airship is outside the Delivery Zone!', X(1), X(2)) %gives warning if airship is not within the figuree
end
radius = sqrt((uavs(1,1)-X(1))^2 +(uavs(1,2)-X(2))^2); % determines the radius using the first UAV
fprintf('\n\nThe location of the airship is (%-5.2f,%-5.2f) and the radius of the cicle is %-5.2f miles',  X(1), X(2), radius)%tells the user where the center of the circle is and what the radius is 

minutes = radius/ 0.5; %The UAVs travel at 0.5 miles per minute so this determines how long the UAVs will take to travel the circle radius
fprintf('\n\nThe return trip time for all 3 UAVs is %-5.2f minute(s) to fly back to the airship.', minutes) %tells the user how long it will take any of the UAVs to reach the center of the circle in minutes

plot(round(uavs(1,1)),round(uavs(1,2)), 'go') %plots the first UAV as a green circle
hold on %makes it so the first UAV is not overridden from the next plot command
plot(round(uavs(2,1)),round(uavs(2,2)),'go') %plots the second UAV as a green circle
hold on
plot(round(uavs(3,1)),round(uavs(3,2)), 'go')%plots the third UAV as a green circle
hold on
plot(X(1), X(2),'*r') %plots the center dot as a red star
hold on
alpha=[0:pi/100:2*pi]; %changes the angle value so that the entire circle can be plotted
plot(X(1)+radius*sin(alpha), X(2)+radius*cos(alpha),'b') %sin is for the X values and cos is for the y values of the circle
axis square
xlim([0 15])
ylim([0 15]) 
xticks([0:1:15])
yticks([0:1:15])
xlabel('X-Coordinates (miles)')
ylabel('Y-Coordinates (miles)') %labels both the X and Y axes
title('Jasper Kimball Amazon UAV Delivery Map') %titles the figure

function det = determinant(X) %takes in a 2x2 matrix and returns the determinant
    det = (X(1,1) * X(2,2) ) - (X(1,2) * X(2,1));
end

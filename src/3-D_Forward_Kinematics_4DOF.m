%% t10, t20 and t30 are used to traverse the loop in order to show the motion of the links
t10 = 0;
t20 = 0;
t30 = 0;
t40 = 0;
%% t1, t2, and t3 are the joint angles which are to be set manually
t1 = pi;
t2 = -pi/4;
t3 = pi/9;
t4 = pi/4;

m = 1;
k = 100;
%% Loop in order to move the links
while m <= k
    [r1, r2, r3, r4, r5] = myfunc(t10, t20, t30, t40);
    r1 = r1.';
    r2 = r2.';
    r3 = r3.';
    r4 = r4.';
    r5 = r5.';
    
    pts1 = [r1; r2];
    plot3(pts1(:,1), pts1(:,2), pts1(:,3),'LineWidth', 2)
    
    grid on
    pbaspect([1 1 1])
    view(3)
    
    hold on
    pts2 = [r3; r2];
    plot3(pts2(:,1), pts2(:,2), pts2(:,3),'LineWidth', 2)
    hold off
    
    hold on 
    pts3 = [r1; [0 0 0]];
    plot3(pts3(:,1), pts3(:,2), pts3(:,3),'LineWidth', 2)    
    hold off
    
    hold on
    pts4 = [r3; r4];
    plot3(pts4(:,1), pts4(:,2), pts4(:,3),'LineWidth', 2)
    hold off
    
    hold on
    pts5 = [r4; r5];
    plot3(pts5(:,1), pts5(:,2), pts5(:,3),'LineWidth', 2)
    hold off
    
    hold on
    scatter3(0,0,0)
    scatter3(r1(1,1),r1(1,2),r1(1,3))
    scatter3(r2(1,1),r2(1,2),r2(1,3))
    scatter3(r3(1,1),r3(1,2),r3(1,3))
    scatter3(r4(1,1),r4(1,2),r4(1,3))
    scatter3(r5(1,1),r5(1,2),r5(1,3))
    hold off
    
    xlim([-8 8])
    ylim([-8 8])
    zlim([-8 8])
    
    pause(0.1)
    
    m = m + 1;
    
    t10 = (m * t1)/k ;
    t20 = (m * t2)/k ;
    t30 = (m * t3)/k ;
    
end
% Function used to calculate the position of the joints with respect to frame 0
function [r1, r2, r3, r4, r5] = myfunc(t1, t2, t3, t4)

    T01 = [cos(t1) -sin(t1) 0 0;
           sin(t1) cos(t1) 0 0;
           0 0 1 0;
           0 0 0 1];
       
    T12 = [cos(t2) -sin(t2) 0 0;
           0 0 1 0;
           -sin(t2) -cos(t2) 1 0;
           0 0 0 1];
       
    T23 = [cos(t3) -sin(t3) 0 2;
           sin(t3) cos(t3) 0 0;
           0 0 1 0;
           0 0 0 1];
       
    T34 = [cos(t2) -sin(t2) 0 2;
           0 0 1 0;
           -sin(t2) -cos(t2) 1 0;
           0 0 0 1]; 
       
    T04 = (T01 * T12);
    T04 = T04 * T23;
    T04 = T04 * T34;
    
    T03 = (T01 * T12);
    T03 = T03 * T23;
    
    T02 = (T01 * T12);
    
    r1 = T01 * [0; 0; 0; 1];
    r1(4,:) = [];
    
    r2 = T02 * [0; 0; 0; 1];
    r2(4,:) = [];
    
    r3 = T03 * [0; 0; 0; 1];
    r3(4,:) = [];
    
    r4 = T04 * [0; 0; 0; 1];
    r4(4,:) = [];
    
    r5 = T04 * [2; 0; 0; 1];
    r5(4,:) = [];
end
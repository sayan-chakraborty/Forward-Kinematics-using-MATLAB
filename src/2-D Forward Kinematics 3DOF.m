%% t10, t20 and t30 are used to traverse the loop in order to show the motion of the links
t10 = 0;
t20 = 0;
t30 = 0;
%% t1, t2, and t3 are the joint angles which are to be set manually
t1 = pi/2;
t2 = pi/2;
t3 = pi/2;

m = 1;
%% Loop in order to move the links
while m <= 100
    [r1, r2, r3, r4] = myfunc(t10, t20, t30);
    plot([r2(1,1), r1(1,1) ], [r2(2,1), r1(2,1)],'LineWidth', 2)
    
    grid on
    pbaspect([1 1 1])
%     view(3)
    
    hold on
    plot([r3(1,1), r2(1,1)], [r3(2,1), r2(2,1)],'LineWidth', 2)
    hold off
    
    hold on 
    plot([0 r1(1,1)], [0 r1(2,1)],'LineWidth', 2)
    hold off
    
    hold on
    plot([r3(1,1), r4(1,1)], [r3(2,1), r4(2,1)],'LineWidth', 2)
    hold off
    
    hold on
    plot(0, 0, 'o', 'MarkerSize', 5, 'LineWidth', 2)
    plot(r1(1,1), r1(2,1),'o', 'MarkerSize', 5, 'LineWidth', 2)
    plot(r2(1,1), r2(2,1),'o', 'MarkerSize', 5, 'LineWidth', 2)
    plot(r3(1,1), r3(2,1),'o', 'MarkerSize', 5, 'LineWidth', 2)
    plot(r4(1,1), r4(2,1),'o', 'MarkerSize', 5, 'LineWidth', 2)
    hold off
    
    xlim([-8 8])
    ylim([-8 8])
    
    pause(0.1)
    
    m = m + 1;
    t10 = (m * t1)/100 ;
    t20 = (m * t2)/100 ;
    t30 = (m * t3)/100 ;
    
end
% Function used to calculate the position of the joints with respect to frame 0
function [r1, r2, r3, r4] = myfunc(t1, t2, t3)

    T01 = [cos(t1) -sin(t1) 0 0;
           sin(t1) cos(t1) 0 0;
           0 0 1 0;
           0 0 0 1];
       
    T12 = [cos(t2) -sin(t2) 0 2;
           sin(t2) cos(t2) 0 0;
           0 0 1 0;
           0 0 0 1];
       
    T23 = [cos(t3) -sin(t3) 0 2;
           sin(t3) cos(t3) 0 0;
           0 0 1 0;
           0 0 0 1];
       
    T03 = (T01 * T12);
    T03 = T03 * T23;
    T02 = (T01 * T12);
    
    r1 = T01 * [0; 0; 0; 1];
    r1(4,:) = [];
    
    r2 = T02 * [0; 0; 0; 1];
    r2(4,:) = [];
    
    r3 = T03 * [0; 0; 0; 1];
    r3(4,:) = [];
    
    r4 = T03 * [2; 0; 0; 1];
    r4(4,:) = [];
    
end
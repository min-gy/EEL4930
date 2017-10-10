function iir ()

    d = dlmread('corrupted_speech.txt');
    fs = dlmread('fs.txt');
    X = dlmread('music.txt');
    
    %define filter order M, step size a, and initialize weights with
    %randn()
    a = 0.01;
    u = .2;
    one_minus_u = 1-u;
    min_order = 5;
    stepsize = 5;
    max_order = 100;
    fixed_order_for_u = 100;

    X_k = padarray(X.', [max_order-1,0], 0, 'post');
    
    erle_plot_index = [min_order:stepsize:max_order];
    erle = zeros(max_order/stepsize,1);
    erle_counter = 1;
    w = zeros(size(X,1), max_order);
    Y = zeros(size(X, 1), 1);
    J = zeros(size(X, 1), 1);
    e = zeros(size(X, 1), 1);
    
    erle_u_plot_index = [.1:.1:.9];
    erle_u = zeros(length(erle_u_plot_index),1);
    erle_u_counter = 1;

    for M = min_order:stepsize:max_order
        %step through sample i in the time series
        e = zeros(size(X, 1), 1);
        X_k = padarray(X.', [max_order-1,0], 0, 'post');
        w = zeros(size(X,1), max_order);
        
        %Choosing fixed order to see different u values
        if M == fixed_order_for_u
            for uu = .1:.1:.9
                e = zeros(size(X, 1), 1);
                X_k = padarray(X.', [max_order-1,0], 0, 'post');
                w = zeros(size(X,1), max_order);
                
                for i = 1:size(X,1)
                    if i > 1
                        for k = 2:M
                            X_k(k,i) = (1-uu)*X_k(k,i-1)+ uu*X_k(k-1,i-1);
                        end
                    end
                    Y(i) = w(i,:)*X_k(:,i);
                    e(i) = d(i)-Y(i);
                    J(i) = e(i)^2;
                    w(i+1,:) = w(i,:) + (2*a*e(i)*X_k(:,i)).';
                end
                temp = 10*log10((d.'*d)/(e.'*e));
                erle_u(erle_u_counter) = temp;
                erle_u_counter = erle_u_counter+1;
            end
            subplot(2,2,4);
            plot(erle_u_plot_index, erle_u);
            title('Fixed Filter Order of 30 with Varied u');
            ylabel('ERLE Value');
            xlabel('Feedback Paramter');
        end
        
        %clear
        e = zeros(size(X, 1), 1);
        X_k = padarray(X.', [max_order-1,0], 0, 'post');
        w = zeros(size(X,1), max_order);
        
        %actual main loop
        for i = 1:size(X,1)
            if i > 1
                for k = 2:M
                    X_k(k,i) = (1-u)*X_k(k,i-1)+ u*X_k(k-1,i-1);
                end
            end
            Y(i) = w(i,:)*X_k(:,i);
            e(i) = d(i)-Y(i);
            J(i) = e(i)^2;
            w(i+1,:) = w(i,:) + (2*a*e(i)*X_k(:,i)).';
        end
        temp = 10*log10((d.'*d)/(e.'*e));
        erle(erle_counter) = temp;
        erle_counter = erle_counter+1;
    end
        
    %plots
    subplot(2,2,1);
    hold;
    for i = 1:max_order
        plot(w(:,i));
    end
    title('Weight Tracks Across Sample');
    xlabel('Audio Sample as a Time Series');
    ylabel('Weight Values');

    subplot(2,2,2);
    plot(J);
    title('Learning Curve');
    xlabel('Audio Sample as a Time Series');
    ylabel('Error^2');

    subplot(2,2,3)
    plot(erle_plot_index, erle);
    title('ERLE Plot');
    xlabel('Filter Order');
    ylabel('ERLE Value');
    
    %play sound
    sound(e,fs);
end
function assignment_2()

    sp = importdata('spheres.txt');
    el = importdata('ellipsoids.txt');
    sw = importdata('swissroll.txt');
   
    %finding covariance
    cov_sp = cov(sp);
    cov_el = cov(el);
    cov_sw = cov(sw);
    
    %finding eigenvalues and eigenvectors
    [evec_sp,eval_sp] = eig(cov_sp);
    [evec_el,eval_el] = eig(cov_el);
    [evec_sw,eval_sw] = eig(cov_sw);
    
    disp('Covariance matrix of Sphere');
    disp(cov_sp);
    disp('Covariance matrix of Ellipse');
    disp(cov_el);
    disp('Covariance matrix of Swiss Roll');
    disp(cov_sw);
    disp('Eigenvectors of covariance matrix of Sphere');
    disp(evec_sp);
    disp('Eigenvalues of covariance matrix of Sphere');
    disp(eval_sp);
    disp('Eigenvectors of covariance matrix of Ellipse');
    disp(evec_el);
    disp('Eigenvalues of covariance matrix of Ellipse');
    disp(eval_el);
    disp('Eigenvectors of covariance matrix of Swiss Roll');
    disp(evec_sw);
    disp('Eigenvalues of covariance matrix of Swiss Roll');
    disp(eval_sw);
    
    
    
    %sort eigenvectors by eigenvalues in descending order
    evec_sp_sorted = sort_eig(eval_sp, evec_sp);
    evec_el_sorted = sort_eig(eval_el, evec_el);
    evec_sw_sorted = sort_eig(eval_sw, evec_sw);
    
    %3D plot
    subplot(3,3,1);
    plot3d(sp);
    title('Sphere 3D');
    subplot(3,3,2);
    plot3d(el);
    title('Ellipse 3D')
    subplot(3,3,3);
    plot3d(sw);
    title('Swiss Roll 3D');
    
    %2D principle components
    y_sp_2 = evec_sp_sorted(1:2,:)*sp';
    subplot(3,3,7);
    plot(y_sp_2(1,:), y_sp_2(2,:), '.');
    title('Sphere 2D');
    
    y_el_2 = evec_el_sorted(1:2,:)*el';
    subplot(3,3,8);
    plot(y_el_2(1,:), y_el_2(2,:),'.');
    title('Ellipse 2D')
    
    y_sw_2 = evec_sw_sorted(1:2,:)*sw';
    subplot(3,3,9);
    plot(y_sw_2(1,:), y_sw_2(2,:), '.');
    title('Swiss Roll 2D');
    
    %1D principle components
    y_sp_1 = evec_sp_sorted(1,:)*sp';
    subplot(3,3,4);
    plot(y_sp_1(1,:), 0, '.');
    title('Sphere 1D');
    
    y_el_1 = evec_el_sorted(1,:)*el';
    subplot(3,3,5);
    plot(y_el_1(1,:), 0, '.');
    title('Ellipse 1D');
    
    y_sw_1 = evec_sw_sorted(1,:)*sw';
    subplot(3,3,6);
    plot(y_sw_1(1,:), 0, '.');
    title('Swiss Roll 1D');
    
    
    function [evec] = sort_eig(eval, evec)
        %returns a matrix of row vectors of eigenvectors sorted by its
        %corresponding eigenvalues in descending order
        eval_diag = diag(eval);
        [~,idx] = sort(eval_diag(:,1)); 
        idx = flipud(idx);
        evec = evec(:, idx);
        evec = evec.'; 
    end
    
    function [] = plot3d(X)

        plot3(X(:,1), X(:,2), X(:,3),'.');
        grid on;

    end
end




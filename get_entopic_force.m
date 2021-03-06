function[force]= get_entopic_force(cur_macrostate)
% /* --- Monte Carlo path sampling --- */
dt=0.05;
num_sample_paths=100;
num_time_steps=100;
% cur_macrostate=[pi,-0.2]';

num_dofs=max(size(cur_macrostate));
sample_paths=zeros(num_dofs,num_time_steps,num_sample_paths);
log_volumes=zeros(1,1,num_sample_paths);
initial_force=zeros(num_dofs,1,num_sample_paths);
% sigma = [1 0; 0 1]/310;
sigma=1/1410;
R=chol(sigma);
% sample_paths = EMPTY_PATH_LIST();
for i = 1:num_sample_paths
    cur_path = zeros(num_dofs,num_time_steps);
    cur_state = cur_macrostate
    thermal_noise=[zeros(num_dofs/2,1);(randn(1,num_dofs/2)*R)'];    
    initial_force(:,:,i)=thermal_noise;
    for n = 1:num_time_steps
        cur_path(:,n) = cur_state;
        localincr=tdmethod(eof,cur_state,dt);
        cur_state = cur_state+localincr+thermal_noise;
        cur_state(1)=mod(cur_state(1),2*pi);
        thermal_noise=[zeros(num_dofs/2,1);(randn(1,num_dofs/2)*R)'];        
    end
    sample_paths(:,:,i) = cur_path;
    log_volumes(:,:,i)=-log(get_volume(cur_path));
end
% /* --- Kernel density estimation of log volume fractions --- */    
% log_volume_fracs = LOG_VOLUME_FRACTIONS(sample_paths);

% /* --- Sum force contributions --- */
% force = zeros(num_dofs,1);
log_volume_fracs=log_volumes-sum(log_volumes,3);
force=sum(bsxfun(@times,initial_force,log_volume_fracs);
% for i = 1:num_sample_paths
%     force =force+initial_force(:,:,i) * log_volume_fracs(:,:);
% end
force=2 * (T_c / T_r) * (1.0 / num_sample_paths) * force;
end
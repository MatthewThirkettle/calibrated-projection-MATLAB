addpath ./Results
filename_excel = '../Application_Results_20181223.xlsx';


%% Component 1
sheet = 2;

% Alpha = 0.05
load('KMS_Application_results_KMS_DGP=9_coverage=95_component=1_rhoUB=0.852018_12_19_13_08_38.mat')
data = round(KMS_confidence_interval,4);
xlRange = strcat('B',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
xlRange = 'D3';
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
xlRange = strcat('J',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

KMS_output.num_feas_DS 

% % Alpha = 0.10
% load('KMS_Application_results_KMS_DGP=9_coverage=90_component=1_2018_12_04_12_47_49.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D15';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% % Alpha = 0.15
% load('KMS_Application_results_KMS_DGP=9_coverage=85_component=1_2018_12_05_04_51_48.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D27';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)


%% Component 2
sheet = 3;

% Alpha = 0.05
load('KMS_Application_results_KMS_DGP=9_coverage=95_component=2_rhoUB=0.852018_12_19_19_14_42.mat')
data = round(KMS_confidence_interval,4);
xlRange = strcat('B',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
xlRange = 'D3';
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
xlRange = strcat('J',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

KMS_output.num_feas_DS 

% 
% % Alpha = 0.10
% load('KMS_Application_results_KMS_DGP=9_coverage=90_component=2_2018_12_04_14_31_40.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D15';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% % Alpha = 0.15
% load('KMS_Application_results_KMS_DGP=9_coverage=85_component=2_2018_12_05_07_06_28.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D27';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)




%% Component 3
sheet = 4;

% Alpha = 0.05
 load('KMS_Application_results_KMS_DGP=9_coverage=95_component=3_rhoUB=0.852018_12_19_22_29_42.mat')
data = round(KMS_confidence_interval,4);
xlRange = strcat('B',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
xlRange = 'D3';
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
xlRange = strcat('J',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

KMS_output.num_feas_DS 

% 
% % Alpha = 0.10
% load('KMS_Application_results_KMS_DGP=9_coverage=90_component=3_2018_12_04_16_31_46.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D15';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% % Alpha = 0.15
% load('KMS_Application_results_KMS_DGP=9_coverage=85_component=3_2018_12_05_08_11_33.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D27';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)


%% Component 4
sheet = 5;

% Alpha = 0.05
 load('KMS_Application_results_KMS_DGP=9_coverage=95_component=4_rhoUB=0.852018_12_20_01_29_10.mat')
data = round(KMS_confidence_interval,4);
xlRange = strcat('B',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
xlRange = 'D3';
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
xlRange = strcat('J',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

KMS_output.num_feas_DS 


% % Alpha = 0.10
% load('KMS_Application_results_KMS_DGP=9_coverage=90_component=4_2018_12_04_19_15_25.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D15';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% % Alpha = 0.15
% load('KMS_Application_results_KMS_DGP=9_coverage=85_component=4_2018_12_05_10_10_59.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D27';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)


%% Component 5
sheet = 6;

% Alpha = 0.05
load('KMS_Application_results_KMS_DGP=9_coverage=95_component=5_rhoUB=0.852018_12_20_05_17_22.mat')
data = round(KMS_confidence_interval,4);
xlRange = strcat('B',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
xlRange = 'D3';
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
xlRange = strcat('J',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

KMS_output.num_feas_DS 


% % Alpha = 0.10
% load('KMS_Application_results_KMS_DGP=9_coverage=90_component=5_2018_12_04_21_02_49.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D15';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% % Alpha = 0.15
% load('KMS_Application_results_KMS_DGP=9_coverage=85_component=5_2018_12_05_10_36_03.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D27';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)


%% Component 6
sheet = 7;

% Alpha = 0.05
load('KMS_Application_results_KMS_DGP=9_coverage=95_component=6_rhoUB=0.852018_12_20_09_17_35.mat')
data = round(KMS_confidence_interval,4);
xlRange = strcat('B',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
xlRange = 'D3';
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
xlRange = strcat('J',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

KMS_output.num_feas_DS 


% % Alpha = 0.10
% load('KMS_Application_results_KMS_DGP=9_coverage=90_component=6_2018_12_05_00_17_31.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D15';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% % Alpha = 0.15
% load('KMS_Application_results_KMS_DGP=9_coverage=85_component=6_2018_12_05_12_07_08.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D27';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)


%% Component 7
sheet = 8;

% Alpha = 0.05
 load('KMS_Application_results_KMS_DGP=9_coverage=95_component=7_rhoUB=0.852018_12_20_12_38_19.mat')
data = round(KMS_confidence_interval,4);
xlRange = strcat('B',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
xlRange = 'D3';
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
xlRange = strcat('J',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

KMS_output.num_feas_DS 

% % Alpha = 0.10
% load('KMS_Application_results_KMS_DGP=9_coverage=90_component=7_2018_12_05_01_46_34.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D15';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% % Alpha = 0.15
% load('KMS_Application_results_KMS_DGP=9_coverage=85_component=7_2018_12_05_12_51_17.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D27';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)


%% Component 8
sheet = 9;

% Alpha = 0.05
 load('KMS_Application_results_KMS_DGP=9_coverage=95_component=8_rhoUB=0.852018_12_20_15_47_16.mat')
data = round(KMS_confidence_interval,4);
xlRange = strcat('B',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
xlRange = 'D3';
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
xlRange = strcat('J',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

KMS_output.num_feas_DS 

% % Alpha = 0.10
% load('KMS_Application_results_KMS_DGP=9_coverage=90_component=8_2018_12_05_02_33_11.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D15';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% % Alpha = 0.15
% load('KMS_Application_results_KMS_DGP=9_coverage=85_component=8_2018_12_05_13_22_10.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D27';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)


%% Component 9
sheet = 10;

% Alpha = 0.05
 load('KMS_Application_results_KMS_DGP=9_coverage=95_component=9_rhoUB=0.852018_12_20_16_58_13.mat')
data = round(KMS_confidence_interval,4);
xlRange = strcat('B',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
xlRange = 'D3';
xlswrite(filename_excel,data,sheet,xlRange)

data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
xlRange = strcat('J',num2str(sheet+1));
xlswrite(filename_excel,data,sheet,xlRange)

KMS_output.num_feas_DS 

% % Alpha = 0.10
% load('KMS_Application_results_KMS_DGP=9_coverage=90_component=9_2018_12_05_02_51_42.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D15';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+13));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% % Alpha = 0.15
% load('KMS_Application_results_KMS_DGP=9_coverage=85_component=9_2018_12_05_14_44_52.mat')
% data = round(KMS_confidence_interval,4);
% xlRange = strcat('B',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.thetaL_EAM',KMS_output.thetaL_opt_DS,KMS_output.thetaU_EAM',KMS_output.thetaU_opt_DS],4);
% xlRange = 'D27';
% xlswrite(filename_excel,data,sheet,xlRange)
% 
% data = round([KMS_output.time_EAM,KMS_output.time_DS,timeKMS]/60,2);
% xlRange = strcat('J',num2str(sheet+25));
% xlswrite(filename_excel,data,sheet,xlRange)




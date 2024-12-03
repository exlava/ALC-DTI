#! /bin/bash

# This is the main script for DTI analysis of Alcohol-Sex study
# oozalay@unmc.edu




# Declare folders here
base_path=/home/ozgun/AnV/Alcohol
data_dir=$base_path/Data
script_dir=$base_path/Scripts
analysis_dir=$base_path/Analysis
result_dir=$base_path/Results
stat_dir=$base_path/Stats

# Source helper functions and variables
source $script_dir/Helpers.sh



###################################
# 1)Copy Data to Analysis folders #
###################################

source $script_dir/001_Copy_Data.sh


##############################################
# 2)Fix Phase Direction problem in DTI scans #
##############################################

source $script_dir/002_Fix_Phase_Dir.sh


##########################################################################
# 3)TopUp - Correct distortions caused by magnetic field inhomogeneities #
##########################################################################

source $script_dir/003_Topup.sh


#############################
# 4)Eddy current correction #
#############################

source $script_dir/004_Eddy_Corr.sh


#####################
# 5)Fit tensor data #
#####################

source $script_dir/005_Dtifit.sh


######################
# 6) TBSS processing #
######################

source $script_dir/006_Tbss.sh

# Run the stats for TBSS
# Create design.con & design.mat in the Results/TBSS/stats folder manually
#cd $result_dir/TBSS/stats
#randomise -i all_FA_skeletonised.nii.gz -o tbss -m mean_FA_skeleton_mask.nii.gz -d design.mat -t design.con -n 500 --T2 -V


###############
# 7) BedpostX #
###############

source $script_dir/007_Bedpostx.sh


#####################################
# 8) Template <--> DTI registration #
#####################################

source $script_dir/008_Reg_MNI2DTI.sh


#################################
# 9) Probabilistic Tractography #
#################################

source $script_dir/009_Probtrackx.sh


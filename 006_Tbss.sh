#! /bin/bash

cd $analysis_dir

echo -e "\n"
echo -e "${BWhite}Step 006:${Color_Off} Tract-based Spatial Statistics for Subject:"
echo -e "\n"

# Create TBSS directory in Results folder to run the analysis
mkdir -p $result_dir/TBSS


for subject in `cat subj_list.txt`;
do

echo -e $subject

# Copy FA data to TBSS folder
cp $analysis_dir/$subject/DTI/Dtifit/dti_FA.nii.gz $result_dir/TBSS/"$subject"_dti_FA.nii.gz

done


cd $result_dir/TBSS

echo "Step 1: Preprocessing..."
tbss_1_preproc *.nii.gz

echo "Step 2: Calculate warps needed to register data to MNI space..."
# We will use the FA template “FMRIB58_FA_1mm” with "-T" parameter
tbss_2_reg -T

echo "Step 3: Apply warps & bring FA to MNI space..."
tbss_3_postreg -S

echo "Step 4: Project all FA onto the skeleton..."
tbss_4_prestats 0.3

echo -e "\n"


echo -e "\n"
echo -e "${Green}Step 006 completed!"
echo -e "${Color_Off}###################\n"
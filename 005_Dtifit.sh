#! /bin/bash

cd $analysis_dir

echo -e "\n"
echo -e "${BWhite}Step 005:${Color_Off} Fitting tensor data for Subject:"
echo -e "\n"

for subject in `cat subj_list.txt`;
do

echo -e $subject

# Create folder
mkdir -p $analysis_dir/$subject/DTI/Dtifit

# Copy necessary files for dtifit
cp $analysis_dir/$subject/DTI/Eddy/AP_eddy_unwarped.nii.gz $analysis_dir/$subject/DTI/Dtifit/data.nii.gz
cp $analysis_dir/$subject/DTI/Eddy/AP_brain_mask.nii.gz $analysis_dir/$subject/DTI/Dtifit/nodif_brain_mask.nii.gz
cp $analysis_dir/$subject/DTI/Eddy/AP.bval $analysis_dir/$subject/DTI/Dtifit/bvals
cp $analysis_dir/$subject/DTI/Eddy/AP.bvec $analysis_dir/$subject/DTI/Dtifit/bvecs

# Run dtifit
cd $analysis_dir/$subject/DTI/Dtifit
dtifit --data=data.nii.gz --mask=nodif_brain_mask.nii.gz --bvecs=bvecs --bvals=bvals --out=dti

echo -e "\n"
done


echo -e "\n"
echo -e "${Green}Step 005 completed!"
echo -e "${Color_Off}###################\n"
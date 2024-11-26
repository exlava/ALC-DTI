#! /bin/bash

cd $analysis_dir

echo -e "\n"
echo -e "${BWhite}Step 007:${Color_Off} BedpostX for Subject:"
echo -e "\n"


for subject in `cat subj_list.txt`;
do

echo -e $subject

# Create folder
mkdir -p $analysis_dir/$subject/DTI/Bedpostx


cp $analysis_dir/$subject/DTI/Dtifit/data.nii.gz $analysis_dir/$subject/DTI/Bedpostx/data.nii.gz
cp $analysis_dir/$subject/DTI/Dtifit/nodif_brain_mask.nii.gz $analysis_dir/$subject/DTI/Bedpostx/nodif_brain_mask.nii.gz
cp $analysis_dir/$subject/DTI/Dtifit/bvals $analysis_dir/$subject/DTI/Bedpostx/bvals
cp $analysis_dir/$subject/DTI/Dtifit/bvecs $analysis_dir/$subject/DTI/Bedpostx/bvecs


bedpostx_gpu $analysis_dir/$subject/DTI/Bedpostx


echo -e "\n"
done


echo -e "\n"
echo -e "${Green}Step 007 completed!"
echo -e "${Color_Off}###################\n"
#! /bin/bash

cd $analysis_dir

# Create a subject list
ls -d */ | cut -f1 -d'/'  > subj_list.txt

echo -e "\n"
echo -e "${BWhite}Step 002:${Color_Off} Correcting filenames and copying necesary files for subject:"
echo -e "\n"

for subject in `cat $analysis_dir/subj_list.txt`;
do

echo -e $subject
mv $analysis_dir/$subject/DTI/DTIap.nii $analysis_dir/$subject/DTI/DTI_PA.nii 
mv $analysis_dir/$subject/DTI/DTIpa.nii $analysis_dir/$subject/DTI/DTI_AP.nii
mv $analysis_dir/$subject/DTI/DTIpa.bval $analysis_dir/$subject/DTI/DTI_AP.bval
mv $analysis_dir/$subject/DTI/DTIpa.bvec $analysis_dir/$subject/DTI/DTI_AP.bvec
mv $analysis_dir/$subject/DTI/DTIpa.json $analysis_dir/$subject/DTI/DTI_AP.json

rm $analysis_dir/$subject/DTI/DTIap.bval $analysis_dir/$subject/DTI/DTIap.bvec $analysis_dir/$subject/DTI/DTIap.json

done

echo -e "\n"
echo -e "${Green}Step 002 completed!"
echo -e "${Color_Off}###################\n"
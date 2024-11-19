#! /bin/bash

cd $data_dir

# Create a subject list
ls -d */ | cut -f1 -d'/'  > subj_list.txt

echo -e "\n"
echo -e "${BWhite}Step 001:${Color_Off} Creating Analysis Folders and move scans for subject:"
echo -e "\n"

for subject in `cat $data_dir/subj_list.txt`;
do

# Create sub-folders for T1 and DTI scans
echo $subject
mkdir -p $analysis_dir/"$subject"/T1 $analysis_dir/"$subject"/DTI

# Move scans to the corresponding folder
cp $data_dir/$subject/anat/*T1w.nii $analysis_dir/$subject/T1/T1.nii
cp $data_dir/$subject/DTI/DTIap.* $analysis_dir/$subject/DTI
cp $data_dir/$subject/DTI/DTIpa.* $analysis_dir/$subject/DTI

done

# Delete subject list
rm $data_dir/subj_list.txt

echo -e "\n"
echo -e "${Green}Step 001 completed!"
echo -e "${Color_Off}###################\n"


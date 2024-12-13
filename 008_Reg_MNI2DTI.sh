#! /bin/bash

# Seed & Targets
Amyg_L_MNI=$script_dir/ROIs/Amygdala_L_MNI_1mm.nii.gz
Amyg_R_MNI=$script_dir/ROIs/Amygdala_R_MNI_1mm.nii.gz
BNST_L_MNI=$script_dir/ROIs/BNST_L_MNI_1mm.nii.gz
BNST_R_MNI=$script_dir/ROIs/BNST_R_MNI_1mm.nii.gz
Hipp_L_MNI=$script_dir/ROIs/Hippocampus_Ant_L_MNI_1mm.nii.gz
Hipp_R_MNI=$script_dir/ROIs/Hippocampus_Ant_R_MNI_1mm.nii.gz
Hypo_L_MNI=$script_dir/ROIs/Hypothalamus_L_MNI_1mm.nii.gz
Hypo_R_MNI=$script_dir/ROIs/Hypothalamus_R_MNI_1mm.nii.gz
Insl_L_MNI=$script_dir/ROIs/Insula_ant_L_MNI.nii.gz
Insl_R_MNI=$script_dir/ROIs/Insula_ant_R_MNI.nii.gz
vmPF_L_MNI=$script_dir/ROIs/vmPFC_L_MNI_1mm.nii.gz
vmPF_R_MNI=$script_dir/ROIs/vmPFC_R_MNI_1mm.nii.gz


cd $analysis_dir

echo -e "\n"
echo -e "${BWhite}Step 008:${Color_Off} Registering Subject:"
echo -e "\n"

for subject in `cat subj_list.txt`; do

echo -e $subject

# Create folder for registration matrices and outputs
reg_folder=$analysis_dir/$subject/DTI/Reg
roi_folder=$analysis_dir/$subject/DTI/Reg/ROIs
mkdir -p $roi_folder

cd $reg_folder


# Register MNI152 to subject nodif_brain
nodif_brain=$analysis_dir/$subject/DTI/Eddy/AP_brain.nii.gz
template=$script_dir/Templates/MNI152_T1_1mm_brain.nii.gz



antsRegistrationSyNQuick.sh \
  -d 3 \
  -f $nodif_brain \
  -m $template \
  -o MNI2DTI_ \
  -t s 


# Use reg matrices to transform ROIs from MNI to individual DTI space
  declare -a ROIArray=("Amyg_L_MNI" "Amyg_R_MNI" \
                       "BNST_L_MNI" "BNST_R_MNI" \
                       "Hipp_L_MNI" "Hipp_R_MNI" \
                       "Insl_L_MNI" "Insl_R_MNI" \
                       "vmPF_L_MNI" "vmPF_R_MNI" \
                       "Hypo_L_MNI" "Hypo_R_MNI")

for ROI in ${ROIArray[@]} ; do

warp=$reg_folder/MNI2DTI_1Warp.nii.gz
affn=$reg_folder/MNI2DTI_0GenericAffine.mat

echo -e "Transforming: "$ROI

antsApplyTransforms \
  -d 3 \
  -i ${!ROI} \
  -r $nodif_brain \
  -t $warp \
  -t $affn \
  -n GenericLabel \
  -o $roi_folder/${ROI:0:7}DTI.nii.gz

done


done

echo -e "\n"
echo -e "${Green}Step 008 completed!"
echo -e "${Color_Off}###################\n"
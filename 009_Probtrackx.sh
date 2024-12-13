#! /bin/bash

cd $analysis_dir

echo -e "\n"
echo -e "${BWhite}Step 009:${Color_Off} Tracking Subject:"
echo -e "\n"

for subject in `cat subj_list.txt`; do

echo -e $subject
probx_dir=$analysis_dir/$subject/DTI/Probtrackx

# If folder already exists remove it
if [[ -d $probx_dir ]]; then
	rm -rf $probx_dir
fi

# Create folder for results 
mkdir -p $probx_dir

# Declare ROIs
  declare -a ROIArray=("Amyg_L_DTI" "Amyg_R_DTI" \
                       "BNST_L_DTI" "BNST_R_DTI" \
                       "Hipp_L_DTI" "Hipp_R_DTI" \
                       "Insl_L_DTI" "Insl_R_DTI" \
                       "vmPF_L_DTI" "vmPF_R_DTI" \
                       "Hypo_L_DTI" "Hypo_R_DTI")

for ROI in ${ROIArray[@]} ; do

# insert ROI file locations to the seed/target list
echo -e $analysis_dir/$subject/DTI/Reg/ROIs/$ROI.nii.gz >> $probx_dir/BNST_Network_ROIs.txt

done


# Run
probtrackx2 \
		--network \
		-x $probx_dir/BNST_Network_ROIs.txt  \
		-l \
		--onewaycondition \
		-c 0.2 \
		-S 5000 \
		--steplength=0.5 \
		-P 1000 \
		--fibthresh=0.01 \
		--distthresh=0.0 \
		--sampvox=0.0 \
		--forcedir \
		--opd \
		-s $analysis_dir/$subject/DTI/Bedpostx.bedpostX/merged \
		-m $analysis_dir/$subject/DTI/Bedpostx.bedpostX/nodif_brain_mask \
		--dir=$probx_dir


done

echo -e "\n"
echo -e "${Green}Step 009 completed!"
echo -e "${Color_Off}###################\n"
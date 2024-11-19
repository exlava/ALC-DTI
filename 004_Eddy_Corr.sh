#! /bin/bash

cd $analysis_dir

echo -e "\n"
echo -e "${BWhite}Step 004:${Color_Off} Eddy current correction for Subject:"
echo -e "\n"

for subject in `cat subj_list.txt`;
do

echo -e $subject

# Create Eddy folders
mkdir -p $analysis_dir/$subject/DTI/Eddy

# Copy phase corrected scan, bvals, bvecs and acq_params
cp $analysis_dir/$subject/DTI/DTI_AP.bval $analysis_dir/$subject/DTI/Eddy/AP.bval
cp $analysis_dir/$subject/DTI/DTI_AP.bvec $analysis_dir/$subject/DTI/Eddy/AP.bvec
cp $analysis_dir/$subject/DTI/Topup/AP_Corr.nii.gz $analysis_dir/$subject/DTI/Eddy/AP_Corr.nii.gz
cp $analysis_dir/$subject/DTI/Topup/acq_params.txt $analysis_dir/$subject/DTI/Eddy/acq_params.txt
cp $analysis_dir/$subject/DTI/Topup/AP_PA_Topup_fieldcoef.nii.gz $analysis_dir/$subject/DTI/Eddy/AP_PA_Topup_fieldcoef.nii.gz
cp $analysis_dir/$subject/DTI/Topup/AP_PA_Topup_movpar.txt $analysis_dir/$subject/DTI/Eddy/AP_PA_Topup_movpar.txt


# Extract B0 Image 
fslroi $analysis_dir/$subject/DTI/Eddy/AP_Corr.nii.gz $analysis_dir/$subject/DTI/Eddy/AP_1stVol 0 1

# Create a brain mask
bet $analysis_dir/$subject/DTI/Eddy/AP_1stVol $analysis_dir/$subject/DTI/Eddy/AP_brain -m -f 0.2

# Create index file, number of rows is equal to the 4th dim of the image, it is 100 for Alcohol study
for i in {1..100}; do echo "1" >> $analysis_dir/$subject/DTI/Eddy/index.txt; done

# Run eddy current correction
cd $analysis_dir/$subject/DTI/Eddy
eddy --imain=AP_Corr.nii.gz\
	 --mask=AP_brain_mask.nii.gz\
	 --index=index.txt\
	 --acqp=acq_params.txt\
	 --bvecs=AP.bvec\
	 --bvals=AP.bval\
	 --fwhm=0\
	 --topup=AP_PA_Topup\
	 --flm=quadratic\
	 --out=AP_eddy_unwarped\
	 --data_is_shelled

echo -e "Eddy current correction finished for subject\n"
done

echo -e "\n"
echo -e "${Green}Step 004 completed!"
echo -e "${Color_Off}###################\n"
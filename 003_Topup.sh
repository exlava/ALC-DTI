#! /bin/bash

cd $analysis_dir


echo -e "\n"
echo -e "${BWhite}Step 003:${Color_Off} Field inhomogenity correction"
echo -e "\n"


for subject in `cat subj_list.txt`;
do

cd $analysis_dir
mkdir -p $subject/DTI/Topup

echo -e "Processing Subject: "$subject
echo -e "Extracting and merging B0 images"
fslroi $subject/DTI/DTI_AP.nii $subject/DTI/Topup/AP 0 1 
fslroi $subject/DTI/DTI_PA.nii $subject/DTI/Topup/PA 0 1


cd $subject/DTI/Topup
# Merge AP & PA B0 images
fslmerge -t AP_PA AP.nii.gz PA.nii.gz 2>/dev/null

# Create acquisiton parameters file. Last column is 'Total Readout Time' from .json file
echo "0 1 0 0.0959097" > acq_params.txt
echo "0 -1 0 0.0959097" >> acq_params.txt


# Apply Topup
echo -e "Calculating inhomogenity field"

topup --imain=$analysis_dir/$subject/DTI/Topup/AP_PA.nii.gz\
		 --datain=$analysis_dir/$subject/DTI/Topup/acq_params.txt\
		 --config=b02b0.cnf\
		 --out=$analysis_dir/$subject/DTI/Topup/AP_PA_Topup\
		 --nthr=15

echo "Applying field to original AP phase encoded scan"
applytopup --imain=$analysis_dir/$subject/DTI/DTI_AP.nii\
		 --inindex=1\
		 --datain=$analysis_dir/$subject/DTI/Topup/acq_params.txt\
		 --topup=$analysis_dir/$subject/DTI/Topup/AP_PA_Topup\
		 --method=jac\
		 --out=$analysis_dir/$subject/DTI/Topup/AP_Corr

echo -e "Topup finished for subject\n"
done

echo -e "\n"
echo -e "${Green}Step 003 completed!"
echo -e "${Color_Off}###################\n"
#! /bin/bash

cd $analysis_dir

echo -e "\n"
echo -e "${BWhite}Step 010:${Color_Off} Prepare Braingraph files for Subject:"
echo -e "\n"

# Create folder for files
mkdir -p $result_dir/Braingraph

for subject in `cat $analysis_dir/subj_list.txt`; do
echo -e $subject

probx_dir=$analysis_dir/$subject/DTI/Probtrackx
roi_folder=$analysis_dir/$subject/DTI/Reg/ROIs
sizes_txt=$probx_dir/"$subject"_sizes.txt

# Delete if there is already the sizes.txt file in the folder
if [ -f $sizes_txt ]; then
	rm $sizes_txt
fi


# Calculate and save the size of the seeds
for ROI in `cat $probx_dir/BNST_Network_ROIs.txt`; do

ROI_clean=${ROI##*/}
Vols=$(fslstats "$roi_folder"/"$ROI_clean" -V)

set -- $Vols
echo -e $1 >> $sizes_txt

done

# Copy files to Results folder
cp $probx_dir/fdt_network_matrix $result_dir/Braingraph/"$subject"_fdt_network_matrix
cp $probx_dir/waytotal $result_dir/Braingraph/"$subject"_waytotal
cp $sizes_txt $result_dir/Braingraph/"$subject"_sizes.txt

done

echo -e "\n"
echo -e "${Green}Step 010 completed!"
echo -e "${Color_Off}###################\n"
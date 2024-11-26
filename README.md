![Alt text](https://computing.unl.edu/sd/images/logo/2022-23/UNMC-GCHS/UNMCLogo.png)

# **Blackford Lab - MMI/UNMC**
# **Alcohol Study DTI MRI Analysis Script**

## **1. Overview**
This script is designed to analyze Diffusion Tensor Imaging (DTI) MRI data. It performs preprocessing, diffusion tensor calculations, and visualization. Key metrics such as FA (Fractional Anisotropy), MD (Mean Diffusivity), and eigenvalues are extracted.

---

## **2. Features**
- **Preprocessing**: Handles noise reduction, eddy current correction, and motion correction.
- **Tensor Fitting**: Computes diffusion tensors and derived metrics.
- **Visualization**: Generates FA and MD maps, fiber tracts, and other visual outputs.
- **Data Export**: Saves metrics as NIfTI files for further analysis.

---

## **3. Dependencies**
To run this script, you will need:
- **Python**: Version 3.x
- Libraries:
  - `numpy`
  - `scipy`
  - `nibabel`
  - `dipy`
  - `matplotlib`
  - (Other libraries as required)
- **Software** (optional, if not handled by script):
  - FSL (for preprocessing tasks like eddy correction)

---

## **4. Input Data**
### Requirements:
- **File Format**: NIfTI (.nii or .nii.gz)
- **Expected Structure**: 
  - 4D DTI images (x, y, z, directions)
  - Corresponding b-values and b-vectors files
  
### How to Provide Input:
1. Place your input files in the `data/input` directory (or specify their paths in the script's configuration section).
2. Ensure the naming convention matches the following:
   - `dwi.nii.gz` (or equivalent DWI image file)
   - `bvals` (b-values file)
   - `bvecs` (b-vectors file)

---

## **5. Usage**
### Basic Command:
```bash
python analyze_dti.py --input_dir path/to/data --output_dir path/to/output
```

### Optional Arguments:
- `--preprocess`: Include preprocessing steps (default: True).
- `--visualize`: Generate visualizations (default: True).
- `--metrics`: Specify which metrics to extract (e.g., `FA,MD,AD,RD`).

### Example:
```bash
python analyze_dti.py --input_dir ./data/input --output_dir ./data/output --metrics FA,MD
```

---

## **6. Outputs**
### Directory Structure:
The outputs will be saved in the specified output directory with the following structure:
```
output/
│
├── preprocessed/   # Preprocessed images
├── metrics/        # Extracted metrics (FA, MD, etc.)
├── visualizations/ # Generated maps and figures
```

### Key Files:
- `fa_map.nii.gz`: Fractional Anisotropy map
- `md_map.nii.gz`: Mean Diffusivity map
- `fiber_tracts.vtk`: Fiber tractography data (if applicable)

---

## **7. Troubleshooting**
### Common Errors:
1. **File Not Found**: Ensure all input files are in the correct format and directory.
2. **Dependency Issues**: Verify that all required libraries are installed.
3. **Tensor Fitting Failure**: Check that b-values and b-vectors align with the input image.

### Solutions:
- Run `pip install -r requirements.txt` to install dependencies.
- Check the script's log file (`log.txt`) for detailed error messages.

---

## **8. Notes**
- This script assumes data has been acquired and organized according to standard DTI protocols.
- Always validate outputs with a small test dataset before applying to large datasets.


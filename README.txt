# README — Zenodo Archive: Spiral Structure and Galaxy Rotation Model
Version: 1.0  
Authors: Bruce Rout, Cameron Rout  
Contact: bruce.rout@[your email or GitHub handle]  
DOI: 10.5281/zenodo.15605317

## Overview

This archive contains the full paper, code, and data used to develop and test a relativistic mathematical model explaining both the spiral morphology and flat rotation curves of disk galaxies. The model is analytic, metric-preserving, and based on general relativity in rotating polar coordinates. It has been tested against 878 galaxies using raw and processed data from the Southern Hemisphere.

## Directory Structure

SpiralStructure/
├── spiralstructure.pdf # Full paper (v1)
├── README.txt # This file
├── code/
│ ├── Galaxy_Structure/ # MATLAB code and an XML config file
│ └── Some_Galaxies/ # .gif images of representative galaxies
└── data/
└── SalucciData/ # Raw data and rotation curves for ~900 galaxies


## Data Attribution

The galaxy rotation curve data was originally compiled and published by:

- Mathewson, D.S., Ford, V.L., & Buchhorn, M. (1992). *ApJS, 81, 413–659.*

These data are used here under fair academic use for model validation and replication.

## Code

Inside `code/Galaxy_Structure/` you will find:

- Scripts and tools (mostly MATLAB) for fitting velocity curves, modeling spiral structure, and visualizing results
- One XML configuration file for parameter input
- Code is self-contained and designed for reproducibility
- A separate `README_code.md` may be added in a future version

## How to Cite

If you use this archive, please cite:

Rout, B. & Rout, C. (2025). *An Analytic Mathematical Model to Explain the Spiral Structure and Rotation Curve of NGC 3198*. [DOI to be assigned by Zenodo]

## Notes

- This model does not invoke dark matter or MOND
- Results emerge from relativistic geometry applied to rotating reference frames
- Model applies to NGC 3198 and over 870 other galaxies
- .gif images are provided for visual reference; results are derived numerically


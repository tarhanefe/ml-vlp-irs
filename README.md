# Machine Learning-Enhanced Visible Light Positioning in IRS-Assisted Indoor Environments with a Single LED Transmitter

## Overview
This research explores Visible Light Positioning (VLP) using a **single LED transmitter** combined with an **intelligent reflective surface (IRS)**. It evaluates the feasibility of position estimation under **non-line-of-sight (NLoS)** conditions when the line-of-sight (LoS) is blocked. The study compares **classical methods** (Maximum Likelihood Estimation, MLE) and **machine learning-based methods** (K-Nearest Neighbors Regression, KNN, and Fully Connected Neural Networks, FCNN).

## Key Contributions
- Introduced a **time-division multiplexing scheme** for VLP using a single LED transmitter.
- Evaluated NLoS-based location estimation using **directed**, **random**, and **uniform mirror orientations**.
- Compared MLE with the **Cramér-Rao Lower Bound (CRLB)** under varying noise levels.
- Demonstrated the performance of ML models, particularly KNN and FCNN, without requiring prior knowledge of the channel model.

## Simulation Setup
- **Room Dimensions:** 4m × 4m × 3m
- **LED Transmitter:** Positioned centrally on the ceiling with 5W power.
- **IRS Configuration:** 441 individually controllable mirrors located on a wall.
- **Receiver:** Position estimated using NLoS light measurements from mirror orientations.
- **Noise Conditions:** Simulations included Additive White Gaussian Noise (AWGN) with various variances.

## Methodology
1. **Classical Approach:**
   - MLE optimizes power measurements to determine receiver location.
   - Benchmarked using the CRLB.
2. **Machine Learning:**
   - **KNN Regression:** Trains on power measurement datasets and estimates based on k-nearest neighbors.
   - **FCNN:** Predicts location using neural networks, with architectures featuring hidden layers and tanh activation functions.

## Results
- **Mirror Orientations:**
  - Directed and uniform orientations provided better focusing and improved accuracy compared to random orientations.
- **MLE:**
  - Approached the CRLB with increasing Signal-to-Noise Ratio (SNR).
- **KNN & FCNN:**
  - ML models demonstrated competitive performance, especially in high-SNR scenarios.
  - FCNN outperformed KNN under higher noise levels.

## Conclusion
This study highlights the potential of IRS-assisted VLP systems with a single LED transmitter. While classical MLE provides high accuracy, machine learning-based methods offer flexibility and reasonable performance without channel model dependency.

## References
See the full research document for detailed formulas, derivations, and additional references.

## 📖 Citation

If you use this work, please cite:

```bibtex
@article{tarhan2025irs,
  title        = {IRS aided visible light positioning with a single LED transmitter},
  author       = {Efe Tarhan and Furkan Kokdogan and Sinan Gezici},
  journal      = {Digital Signal Processing},
  volume       = {156},
  pages        = {104799},
  year         = {2025},
  publisher    = {Elsevier},
  doi          = {10.1016/j.dsp.2024.104799},
  url          = {https://doi.org/10.1016/j.dsp.2024.104799}
}
```
---

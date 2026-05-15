# Fingerprinting (Side Project)

Exploratory work on **fingerprinting-style** VLP localization using IRS-reflected
power measurements. Two estimators are compared against the classical MLE / CRLB
baseline:

- **k-Nearest-Neighbour regression** on the IRS power vector
- **Fully-connected neural network** trained on simulated power vectors

This work is **not** part of the published *Digital Signal Processing* paper. The
main paper code (CRLB analysis, IRS-profile optimization, MLE benchmarking) lives
one level up — see [../README.md](../README.md).

## Layout

```
fingerprinting/
├── main.m                <- driver script: dataset generation, MLE / CRLB sweeps,
│                            KNN and NN training + RMSE evaluation
├── plotting.m            <- result-plotting cells
├── functions/            <- helper functions (MLE, CRLB, IRS placement,
│                            channel model, KNN/NN training utilities, ...)
├── datasets/
│   ├── train/            <- generated training CSVs (varying mirror count,
│   │                       orientation strategy, noise level)
│   └── test/             <- generated test CSVs
├── results/              <- early MLE / CRLB simulation results (.mat)
└── results_v2/           <- second-pass results
```

## Quick Start

```matlab
% from the repository root
>> setup_paths   % registers fingerprinting/functions/ on the MATLAB path
>> cd fingerprinting
>> edit main.m   % run individual cells; the script is organized as a sequence
                 % of independent experiments (MLE, CRLB, dataset generation,
                 % KNN sweep, NN architecture sweep, ...)
```

`main.m` is organized as %%-delimited cells; run them one at a time rather than
top-to-bottom. Each cell is an independent experiment.

## Typical Experiments

| Cell in `main.m`        | What it does                                                |
|-------------------------|-------------------------------------------------------------|
| Power / CRLB maps       | Computes received-power and CRLB heatmaps over the room     |
| MLE sweeps              | Runs MLE for 9- and 16-measurement scenarios across SNRs    |
| `create_data(...)`      | Synthesizes train/test CSVs at chosen mirror config + noise |
| `KNNRegression(...)`    | Trains and evaluates KNN at varying k and SNR               |
| `nnRegression(...)`     | Trains feed-forward NNs with various hidden-layer widths    |
| `knnrun(...)`           | Sweeps k for KNN regressors trained at different SNRs       |

## Notes

Results in [results/](results/) and [results_v2/](results_v2/) reflect ad-hoc
configurations; treat them as illustrative rather than definitive.

# Calibrated Projection in MATLAB: User's Manual and Package

We present the calibrated-projection MATLAB package implementing the method to construct confidence intervals proposed of **Kaido, Molinari, and Stoye "Confidence Intervals for Projections of Partially Identified Parameters"**, forthcoming at **Econometrica**. This version of the code is what was used to carry out the empirical application in Section 4 of Kaido, Molinari, and Stoye (2019) and the Monte Carlo simulations in Appendix C. Please visit https://molinari.economics.cornell.edu/programs.html for the most up-to-date version of the code.

## Getting Started

The file **calibrated-projection-MATLAB/Manual/KMST_Manual.pdf** provides details  on how to use the package for inference on projections of partially identified parameters and instructions on how to replicate the empirical application and simulation results in the paper.  The package is written in **MATLAB**, but does call **MEX files** that execute a the **CVXGEN** linear prorgram, which is written in **C**. The key steps to run the package are to:

1. Specify the moment (in)equality constraints, the corresponding gradients, and standard deviation estimator.
2. Set up either **CVXGEN** or **CVX**
3. Specify the set of additional options in **KMSoptions.m**.
4. Call the file **KMS_0_Main.m**.

## Working Examples

We have included a set of examples in the package that are discusssed in detail in the manual and in Kaido, Molinari, and Stoye (2019).

1. KT Application: The file **KMS_Application.m** runs the airline application of **Kline and Tamer (2016, Quantitative Economics)**.  This file specifies the additional options and calls  **KMS_0_Main.m**.  The moments, gradients, and standard deviation estimator are included in the files **moments_w.m, moments_theta.m, moments_gradient.m, and moments_stdev.m** under the **DGP=9** if condition.
2. BCS Simulation: The file **BCS_Simulation.m** replicates the simulations for the game proposed in **Bugni, Canay, and Shi (2017, Quantitative Economics)**.  This example corresponds to **DGP=8**.  
3. Monte Carlo Simulations: The file **KMS_Simulation.m** replicates the simulations and there are 8 data-generating processes possible data-generating processes to choose from by setting **DGP** equal to either **1,2,...,7**. 

## References

1. Bugni, F., I. Canay,  and X. Shi  (2017) "Inference for subvectors and other functions of partially identified parameters in moment inequality models," *Quantitative Economics*, 8(1), 1–38..

2. Kaido, H., F. Molinari,  and J. Stoye (2019) "Confidence Intervals for Projections of Partially Identified Parameters," *Forthcoming Econometrica*.

3. Kline, B., and E. Tamer (2016): "Bayesian inference in a class of partially identified models," *Quantitative Economics*, 7(2), 329–366.

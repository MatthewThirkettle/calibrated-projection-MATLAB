# Calibrated Projection in MATLAB: User's Manual and Package

We present the calibrated-projection MATLAB package implementing the method to construct confidence intervals proposed of **Kaido, Molinari, and Stoye "Confidence Intervals for Projections of Partially Identified Parameters"**, forthcoming at **Econometrica**. This version of the code is what was used to carry out the empirical application in Section 4 of Kaido, Molinari, and Stoye (2019) and the Monte Carlo simulations in Appendix C. Please visit https://molinari.economics.cornell.edu/programs.html for the most up-to-date version of the code.

# Getting Started

The file **calibrated-projection-MATLAB/Manual/KMST_Manual.pdf** provides details  on how to use the package for inference on projections of partially identified parameters and instructions on how to replicate the empirical application and simulation results in the paper.  The package is written in **MATLAB**, but does call **MEX files** that execute a the **CVXGEN** linear prorgram, which is written in **C**. The key steps to run the package are:

1. Specify the moment (in)equality constraints, the corresponding gradients, and standard deviation estimator.
2. Set up either **CVXGEN** or **CVX**
3. Specify the set of additional options in **KMSoptions.m**.
4. Call the file **KMS_0_Main.m**.

# Working Examples

We have included working examples in the package: 

1. Application: 
2. Monte Carlo Simulations: There are 8 data-generating processes one can run from the files that replicate the simulations in  **KMS_Simulation.m**.  


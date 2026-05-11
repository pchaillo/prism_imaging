import numpy
import numpy as np
import pandas as pd
from scipy.signal import savgol_filter, find_peaks, find_peaks_cwt, butter, sosfilt
from matplotlib import pyplot as plt

evaluation_method_dict = {
                          "Variance":pd.DataFrame.var,
                          "Standard_Dev":pd.DataFrame.std,
                          "Mean":None
                          }

def noise_estimation_ms(intensities, show=False):
    # Slight modification of the STORM-MSMS noise detection algorithm, with modified input and lowered noise level
    # estimator as MS1 data is usually far less sparse
    full_intensities = intensities.copy()

    sn = 4
    intensities = intensities[intensities != 0]
    if len(intensities)< 0.1*len(full_intensities):
        # If the spectrum is sparse, there is a strong risk to overcommit when selecting an SN ratio. We therefore
        # dynamically assign the target noise level based on spectral quality
        ratio = len(intensities) / (0.1*len(full_intensities))
        min_ratio = 0.8
        max_ratio = 1

        # Clamp the raio for interpolation
        if ratio < min_ratio:
            ratio = min_ratio
        elif ratio > 1:
            ratio = 1

        sn_min = 2
        sn_max = 4
        sn = (sn_min*(max_ratio-ratio) + sn_max*(ratio-min_ratio))/(max_ratio-min_ratio)

    if len(intensities)>10:
        q_num = 10
    else:
        # There just is not enough data in this spectrum to do much of anything
        return 1

    quantiles = pd.qcut(intensities, q=q_num, labels=False, duplicates="drop")
    intensities = pd.DataFrame([intensities, quantiles], index=["m/Z Intensity", "Quantile"]).T
    noise_levels = []

    for quantile in range(len(quantiles.unique()) - 1): # Disregards the last quartile as it is bound to contain signal
        noise = intensities[intensities["Quantile"] <= quantile]
        noise_level = (noise["m/Z Intensity"].mean() + noise["m/Z Intensity"].std()) * sn # Signal should at the very
        # least equate SN=2, so doubling this values brings us to that critical threshold and ensures that we are above the noise
        noise_levels.append(noise_level)

    noise_levels_derivative = np.gradient(noise_levels)
    noise_level = noise_levels[np.where(noise_levels_derivative == max(noise_levels_derivative))[0][0]-1] # Move right before the inflexion point

    if show:
        fig, axs = plt.subplots(1, 2)

        axs[0].plot(range(len(full_intensities)), full_intensities)
        axs[0].axhline(noise_level, color="red", ls="dotted")

        axs[1].plot(range(len(noise_levels)), noise_levels)
        plt.show()
    return noise_level

def noise_estimation_np(intensities:numpy.array, show=False):
    # Lighter version of noise_estimation_ms wih Numpy arrays instead of Pandas Dataframes. This greatly diminishes the
    # performance penalty brought by Pandas
    full_intensities = intensities.copy()
    sn = 4
    intensities = intensities[intensities != 0]
    if len(intensities)< 0.1*len(full_intensities):
        # If the spectrum is sparse, there is a strong risk to overcommit when selecting an SN ratio. We therefore
        # dynamically assign the target noise level based on spectral quality
        ratio = len(intensities) / (0.1*len(full_intensities))
        min_ratio = 0.8
        max_ratio = 1

        # Clamp the raio for interpolation
        if ratio < min_ratio:
            ratio = min_ratio
        elif ratio > 1:
            ratio = 1

        sn_min = 2
        sn_max = 4
        sn = (sn_min*(max_ratio-ratio) + sn_max*(ratio-min_ratio))/(max_ratio-min_ratio)

    if len(intensities)>10:
        q_num = 10
    else:
        # There just is not enough data in this spectrum to do much of anything
        return 1

    bins = np.quantile(intensities, np.linspace(0,1,q_num+1))
    quantiles = np.digitize(intensities, bins[1:])

    noise_levels = []

    for quantile in range(q_num - 1): # Disregards the last quartile as it is bound to contain signal
        noise = intensities[quantiles <= quantile]
        noise_level = (noise.mean() + noise.std()) * sn # Signal should at the very
        # least equate SN=2, so doubling this values brings us to that critical threshold and ensures that we are above the noise
        noise_levels.append(noise_level)

    noise_levels_derivative = np.gradient(noise_levels)

    idx = np.argmax(noise_levels_derivative) - 1

    idx = max(idx, 0)

    noise_level = noise_levels[idx]
    #noise_level = noise_levels[np.where(noise_levels_derivative == max(noise_levels_derivative))[0][0]-1] # Move right before the inflexion point

    if show:
        fig, axs = plt.subplots(1, 2)

        axs[0].plot(range(len(full_intensities)), full_intensities)
        axs[0].axhline(noise_level, color="red", ls="dotted")

        axs[1].plot(range(len(noise_levels)), noise_levels)
        plt.show()
    return noise_level


if __name__ == "__main__":

    print("No testing function for this version as of now")
# EEG-CSP-Filter-Project

## Introduction
 The purpose of this experiment was to decode imagined movement based on Mu Waves. When the body is at rest, Mu Waves manifest at a frequency ranging from 7.5 Hz to 12 Hz. By performing an EEG experiment where the subject imagines performing a task, the suppression and desynchronization of Mu waves in the motor cortex was verified. This type of activity can easily be distinguished by evoking spatially specific patterns of neural activation. The left hand for example, is controlled by the right motor cortex and the right hand is controlled by the left motor cortex. As a result, left and right imaged movements can be decoded when changes in Mu wave common spatial patterns (CSP) are measured. Defined as common technique in signal processing, CSP filtering is a mathematical procedure which separates a multivariate signal into additive and subtractive components. Upon filtering, the algorithm found the best linear combination of electrodes that maximizes the differences between the patterns of activity across conditions. Furthermore, the CSP projections of the two classes were classified with a Linear Discriminant Analysis (LDA) classifier to demonstrate the value of separability using a CSP Filter.

## Note to the reader
This project was intended to highlight applications of machine learning to biological systems. The experiments were run with EEGLAB, an open-source MATLAB Toolbox for Physiological research. Prior to training the CSP classifier with four experimental blocks, the user was able to perform active feedback which measured the associated strength to either side of the brain in real time. The four experimental blocks of data were analyzed with three MATLAB scripts to demonstrate the paradigm of separating and classifying EEG signals based on CSP filtering. 

## Summary of Contributed files
To maximize coverage over the motor cortex, signals were collected across a 16-channel layout. The CSP.locs file specifies the electrode location coordinates which were used and read by the program. A series of additional code are also included in the folder Supplementary Scripts which were sourced from EEGLAB. `Readlocs.m` reads the electrode location coordinates and other information from a file and `Topoplot.m` plots a topographic map of a scalp data field in a 2-D circular view. 

The folder Project Data contains the experiment EEG data and information necessary to separate between left and right imagined movements. The Run Data saved to `classrun1.mat` for example contains a 16-channel EEG response to each stimulation event. The 18th channel was a trigger which documented the time of each stimulation event via binary encoding. Every event was marked with a ‘1’ and all time in between was otherwise ‘0’. Conversely, the Run Info saved to `run1.mat` has two separate lists that were independently created with binary encoding. These two lists are inversions of each other because they represent events with respect to the left or right triggers exclusively. By integrating the Run Info with the trigger sequence from channel 18, the indices for left and right imagined movements were separated.   

Folder Project Code consists of all MATLAB scripts pertaining to project phases prior to training the CSP classifier. The scripts are titled `EEG_Preprocessor.m`, `EEG_Average_Power.m` and `EEG_LDA_Classifier.m` 

During the first phase, the data was pre-processed by reordering the sequence of the data  `EEG_Preprocessor.m` is a script that finds the indices for all events and then separates out the left and right trigger indices based on the Run Info. A selection criteria was applied which specified a start and end index and was scaled by the sampling frequency. The range of indices represents the window of time that is being sampled after each trigger. To obtain feature selection, all epochs were concatenated across all experimental blocks yielding a total of 16 reconfigured channels. Last, the data was passed through a bandpass filter with a range of 8 Hz to 20 Hz to remove unwanted waveform characteristics. The entire process described above was performed for both the left and right triggers separately.

To visualize the differences in brain activity across the two hemispheres, the average power for the left and right sides were calculated with the script `EEG_Average_Power.m`. Utilizing the results, two plots were generated to show the average power of each side for each of the 16 channels. For an alternate view, the same results were passed through the `topoplot()` function along with the `CSP.locs` file. The resultant figures portray three contour plots of the average power over the scalp for each side of the brain and the difference between them.     

The script `EEG_LDA_Classifier.m` applies the CSP filter to the pre-processed data. The covariance matrices were found for each class. By extracting the top six eigen vectors from the CSP matrix with the eigen value function, the most prominent components of the CSP filter were visualized with the `topoplot()` function. To show the impact of CSP filtering, scatter plots were created to show the separability of the two classes before and after applying the transformation. Finally, the normalized and CSP filtered  data was passed through an LDA classifier utilizing K-fold cross validation. See the results section for the outcomes of the classifier.        

## Stimuli and Procedure
Prior to commencing the experiment, the signal quality of the system was verified in real-time using the g.recorder application. To maximize coverage over the motor cortex, a 16-electrode set-up with a sample rate of 256 Hz, a bandpass filter with a range of 0.5 Hz to 30 Hz, and a 60 Hz notch filter was used; the specified filters were used to capture the desired signal and attenuate line noise. Conducting gel was carefully added to the EEG electrodes while the signal for all channels were closely monitored until all channels presented clear signals. 

<p align="center">
  <img src="https://user-images.githubusercontent.com/25239215/115286108-b0a9b400-a11c-11eb-98bb-69dc1be7e36d.png">
</p>

<p align="center"><b> 
  Figure 1. Transverse view of the typical 16-Channel EEG Layout.</b> 
</p>

A 16-channel reading was necessary to maximize signal coverage over the motor cortex where each electrode represents a geographical location on a scalp cap. The channels listed in numerical order were also follows: Fz, F2, F1, FC2, FC1, FC4, FC3, FC6, FC5, C2, C1, C6, C5, CPz, CP3 and CP4. Each electrode was responsible for capturing a portion of the left and right brain signals. By spatially filtering the data, a Topoplot accurately relayed which channels have the strongest association to the hemispheres of the motor cortex.        

The experimental paradigm used in this procedure is summarized in **Figure 2** and consisted of two phases and four distinct steps. Starting with the calibration phase, the subject sat with closed fists and waited for the visual fixation cross to appear on the screen. One second later a beep would sound indicating to get ready to look at the screen for the indication of carrying out left or right motor imagined movements. As soon as the arrow was displayed, the subject thought about squeezing the indicated fist by imagining it with their brain for approximately 3 seconds. After the cue, the subject would have 2 seconds get ready to repeat the training steps again. A total of 4 experimental blocks were performed containing a random sequence of 20 left and right visual cues per block. As a result, there were a total of 80 left imagined movements and 80 right imaged movements amongst all the experimental blocks.

<p align="center">
  <img src="https://user-images.githubusercontent.com/25239215/115286958-b227ac00-a11d-11eb-93b5-9766cb9be72e.png">
</p>

<p align="center"><b> 
  Figure 2. Experimental Paradigm for training a CSP Classifier.</b> 
</p>

After fully training the CSP Classifier, the Feedback Phase was performed. Referencing the experimental paradigm, the procedure was identical to the previous phase but this time with inclusion of the pre-trained classifier and the active feedback step. Including this extra step, the subject would now imagine movement until the active feedback bar disappeared and then relax before the fixation cross appeared again. **Figure 3** captures the explicit differences between the Calibration and Feedback phases in a concise visual below.  

<p align="center">
  <img src="https://user-images.githubusercontent.com/25239215/115287262-0f236200-a11e-11eb-8f42-3548b6656a2d.png">
</p>

<p align="center"><b> 
  Figure 3. Summary of the Calibration and Feedback Phases of the experiment.</b> 
</p>

In summary, the Calibration Phase was used to train the classifier utilizing good quality data from select trials, while the Feedback Phase could actively provide a measurement of the classifier’s effectiveness. During the active feedback step of the experiment, the subject would now focus on the task dictated by the directional cue while the feedback meter indicated the strength between the signal and the associated class. The subject would now have the liberty to see their performance and adjust their “imagined movement thinking” based on the strength of the active feedback meter accordingly.   

<p align="center">
  <img src="https://user-images.githubusercontent.com/25239215/115287353-2d895d80-a11e-11eb-887c-549f913546c4.png">
</p>

<p align="center"><b>
  Figure 4. The arrows signify the directional cue for imagining left and right-hand movement.</b>
</p>

Following the same steps described in the Experimental Paradigm for training a CSP Classifier, four more experimental blocks were recorded to make the CSP filter component calculation.  

## Results
## Training Imagined Movement:
As more trials were performed, improvement across training and accuracy was observed over time. Upon completing the trials for one experimental block, the algorithm was incapable of a response as the subject could not move the feedback meter as much or as quickly for the imagined movements. During the second, third and fourth experimental blocks the subject was always able to move the meter more than halfway to the other end of the screen for every trial. By the third and fourth experimental blocks the subject could move the meter all the way in the desired direction. Note that the desired measurements became easier to make because subject got accustomed on how to control their thoughts and generate the appropriate response for active feedback. During training, it was a bit more difficult to gauge a feel for the imagined movements because there was no way to refer to responses in real time.  

## Average Power for Left and Right Brain Activity:
Observing the average power of the left and right hemispheres of brain channel by channel, the differences in responses are obvious. Referencing **Figure 5**, we can see there are alternating peaks and valleys for both sides of brain activity. Channels FC3 and FC4 are significant because they represent the most active regions of the motor cortex for the left and right hemispheres, containing the highest average power, respectively. Recalling the 16-channel EEG electrode map in **Figure 1**, there is no coincidence that FC3 and FC4 are directly above the motor cortex and pose equidistant from the center of the scalp cap. Note that these channels neighbor each other on the x-axis and mirror each other in terms of their average power. This phenomenon also holds true for all other equidistant pairs of electrodes pertaining to the two hemispheres of the brain such as (F1 vs. F2) and (C5 vs. C6) etc. While this mirrored relationship holds true, we do not expect the average power for each pair of corresponding electrodes to be identical. In the case for this subject, the left brain is clearly more dominant due a more localized response directly over the motor cortex which suggest they are right-handed. 

<p align="center">
  <img src="https://user-images.githubusercontent.com/25239215/115287829-b7392b00-a11e-11eb-9287-c5c2cc879664.PNG">
</p>

<p align="center"><b>
  Figure 5. Average Power for left and right brain activity.</b>
</p>

## Topoplots of Left and Right Brain Activity:
To visualize an overhead perspective of brain activity responses, Topoplots containing a contour map of the signal relative to the electrodes was generated. Considering the results from the plots in **Figure 6**, we can see that most of the activity occurs at FC3 and FC4 for the left and right sides of the brain, respectively. It can also be concluded that the subject was more successful at right imagined movements as the brain activity was more localized to that side. During the active feedback runs, the feedback meter could almost always be pinned all the way to the right side but was harder to keep it pinned to the left as frequently for left imagined movements. For right imagined movements the biggest difference was at FC4 and for left imagined movements the biggest difference was at FC3. It should be noted that the difference is greater near FC3 and extends radially to the surrounding electrodes FC5, FC1, C5, C1, CP3 and F1 suggesting that the signal was localized and contained slightly more brain activity from the left side. The right side of the brain has more residual contours near the back and side of the brain suggesting the right side is non-dominant. In conclusion, the scalp map further confirms that the motor cortex is the region where movement is processed in the brain and that the responses are separable. 

<p align="center">
  <img src="https://user-images.githubusercontent.com/25239215/115291596-f10c3080-a122-11eb-9f57-ec3d2500caab.png">
</p>

<p align="center"><b>
  Figure 6. Listed from L-R: Topoplots of Left, Right and Differenced Brain Activity.</b>
</p>

## Applying Common Spatial Pattern Filters:
To obtain CSP filtered data, the left and right EEG signals were first separated out by a specific selection criterion. This methodology included identifying the range of indices when data was being acquired and using the class run files to identify the sequence of the left and right signaled cues for each experimental block. After separating the data into left and right epochs and concatenating the respective sides into separate vectors, a bandpass filter with a range of 8 Hz to 20 Hz was applied. Next, the covariance matrices across trials for each class were calculated. The general eigen value problem was solved by creating a joint diagonalization of the two covariance matrices. The following mathematical procedure is described in detail below:

<p align="center">
  <img src="https://user-images.githubusercontent.com/25239215/115296717-4b0ff480-a129-11eb-9ab8-48cd9f100159.png">
</p>

The covariance matrices of the separate classes were passed through the eigen value function defined in **Equation 1**. The output of the eigen function provided the eigen vectors (matrix U) and eigen values (vector lambda) where the eigen values increased down the diagonal. Using the U matrix, the top six greatest eigen vectors were extracted to construct the matrix W consisting of the six desired CSP filters. By taking the transpose of the W matrix and multiplying it with the original data as shown in **Equation 2**, the CSP filtered data is now generated. This projection maximizes the discriminative activity S<sub>d</sub> while minimizing common activity S<sub>c</sub> such that the two classes are separated properly. Effectively, this calculation allowed the raw data to be projected or ‘CSP filtered’ thus creating a 6 by time matrix.   

<p align="center">
  <img src="https://user-images.githubusercontent.com/25239215/115294907-2e72bd00-a127-11eb-9989-bda664ecdfdd.png">
</p>

<p align="center"><b>
  Figure 7a and 7b. Comparison between the separability of the two classes before and after CSP filtering.</b>
</p>

Spatial filtering the results allowed for better discrimination between the two classes of data. While the raw data appears to be somewhat separated as seen in Figure 1a suggesting that the experimental data was of reasonable quality, CSP filtering method was able to improve separation as seen in **Figure 7b.** Note that **Figure 7a** compares discrimination between the two classes against the strongest left and right channels while **Figure 7b** compares discrimination between the two strongest ranking CSP filters (eigen values). Spatial filtering also reduces the scale of the data and its standard deviation. 

<p align="center">
  <img src="https://user-images.githubusercontent.com/25239215/115295286-93c6ae00-a127-11eb-984a-8189e5021311.png">
</p>

<b>Figure 8. CSP filters on the scalp where 1-6 denotes the weakest to strongest CSP filter.
Above is the scalp plot of the six strongest CSP filters corresponding to the six highest eigen values. Note the labeling 1-6 represents the weakest to strongest filter in order. The respective eigen values for the filters were 0.9615, 0.8871, 0.8746, 0.6582, 0.6000 and 0.5509.</b>

## Classification in CSP-Projected Space with LDA:
To train the LDA classifier, K-fold cross-validation was performed on the CSP-projected data using a 90/10 train-test split. With a total of 80 trials for this experiment, the data was randomly broken up into 10 folds consisting of 72 trials of training and 8 trials of testing per iteration using the sliding windows method with replacement. The average percent accuracy of the LDA classifier reached 83.75% and the standard deviation was 0.6725. Among ten trials performed with the LDA classifier, there is only one instance where the percent accuracy was below 84%. As mentioned in the Training Imagined Movement results section, improvement across training and accuracy occurred with time. Note that four new experimental blocks were acquired for this procedure and were performed one week after the CSP classifier experiment was performed. Therefore, the outlier observed in trial number 7 had taken influence from the initial experimental block when the subject was getting accustomed to the stimuli when commencing the experiment. 

<p align="center">
  <img src="https://user-images.githubusercontent.com/25239215/115295329-a04b0680-a127-11eb-9d4b-46ed18ccb49b.png">
</p>

<p align="center"><b>
  Figure 9. Percent accuracy plot of the LDA classifier over ten different trials.</b>
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/25239215/115295669-0041ad00-a128-11eb-9a7b-0facf08c0c84.png">
</p>


<p align="center"><b>
  Table 1. Percent accuracy of the LDA classifier over ten different trials</b>
</p>

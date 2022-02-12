# EEG_MotorI_Imagery_Classification
Classification of EEG Motor Imagery by modified CSP and LDA Classifier.
We use MATLAB environment to build the algorhitm

The data was retrieved from Open Source database : http://bnci-horizon-2020.eu/database/data-sets\
The description of the data can be read here : https://lampx.tugraz.at/~bci/database/002-2015/description.pdf

This project is about classifying the Motor Imagery (MI) movements ('Open and Grasp') using the Modifien Common Spatial Pattern (CSP). Then we use the Linear Discriminant Analysis to define the classes and in order to achieve the accuracy of CSP algorhitm.

******CLASSIFICATION OF MOTOR IMAGERY MOVEMENTS FROM EEG AND EOG SIGNALS USING FILTER BANK COMMON SPATIO- SPECTRAL PATTERN 
(FBSCCP) FEATURE EXTRACTION AND LINEAR DISCRIMINANT
 ANALYSIS (LDA) CLASSIFIER
******


Brachial Plexus Injury (BPI) is a disease that shows symptoms of paralysis, current treatment for BPI patients varies from traditional physical therapy which focuses on the patient's physical ability such as therapeutic exercises on walking or picking up glasses that help restore the function of the knee flexion and elbow extension, and neuropharmacology. The use of a combination of Brain-Computer Interface (BCI) and exoskeleton gives better results by imagining hand movements so that it does not focus on physical abilities, especially BPI patients. The purpose of this study is to improve the control performance of the exoskeleton by finding the calculation of the motor imagery performance results from the EEG/EOG signal through the Brain-Computer Neural Interface (BNCI) database using the Filter Bank Common Spatio-Spectral Pattern (FBCSSP) feature extraction and the Linear Discriminant Analysis (LDA) classification algorithm. The results will be classified using the Linear Discriminant Analysis (LDA) method which has advantages, especially distinguishing two types of classes within a shorter time. The result of this study produced the best training results on 4-fold cross-validation using random test results on the remaining 6 cross-validation data with a mean accuracy of 80.55% - 84.72%. This EEG test data has an accuracy percentage of 83.33% - 87.50% mean accuracy for one participant. These results imply that the FBCSSP method is a method that can classify imagery motors with a simple, non-iterative, and fast-training structure.

Keywords: EEG, EOG, FB CSSP, LDA, Exoskeleton

**The Experimental Procedure**

Motor Imagery (MI)-based BCI translates the subject's motor intentions into command signals by analyzing MI status such as imagining movement [10]. The procedure for collecting this data was to collect electroencephalography (EEG) data from a subject with spinal cord lesions and asked to control the BCI EEG/EOG to operate a neuro-prosthetic device attached to the paralyzed right upper arm. The cue-based BCI paradigm consisted of two distinct tasks, namely 'imagining movement' of grasping on the right hand (class 1) and 'relaxation / no movement' (class 2). 

**Signal Retrieval**

In the BCI system, brain activity is measured and then converted into control commands for the controlled device [11]. The brain activity was tapped by electrodes with electrode placement at five locations based on conventional EEG locations (according to the international 10/20 system). used an active electrode EEG system (Acti-cap® and BrainAmp®, Brain Products GmbH, Gilching, Germany) with a reference electrode placed at FCz and a ground electrode at AFz as in Figure 1. EEG was recorded at a sampling rate of 200 Hz, with a time of approx. 120 seconds, bandpass filter at 0.4-70Hz. EOG was recorded according to standard EOG placement on the left and right external canthus (LOC/ROC). Two bipolar EOG channels were recorded at a sampling rate of 200 Hz and referenced to the left and right mastoids.

**Signal Preprocessing**

In the preprocessing phase, the obtained EEG signal is selected in the form of channel, frequency and time, this preprocessing aims to remove information that is not related to Motor Imagery (MI) and this process is represented by Figure 2. The recording results need to be subjected to frequency selection of (8-12 Hz) and (18-26 Hz) according to the report [12], using a band pass butter worth filter as shown in Figure 3 which is the frequency response that will be used in this study. Active segment selection is performed to eliminate interval data before entering the MI assignment. 


**Signal Processing**

After undergoing preprocessing, a spatial filter is needed that can produce MI classification representations in two different classes. Common Spatial Pattern (CSP) is very popular and powerful in spatial filtering method for MI needs. CSP uses the power band feature, CSP calculates a spatial filter, which aims to get the optimal difference between the two classes [13]. Then in optimizing the performance of the CSP, the CSP is modified into a filter bank common spatio-spectral pattern (FBCSSP) to find the required filter parameters by calculating a simple CSP in one go, without iteration [9]. In the first layer FBCSSP, the EEG signal is filtered with a FIR band pass butterworth filter. Then each band passed by the NEEG signal channel is filtered spatially in layers CSP-1 so that the spatial pattern best for each frequency band specified in layers (layer) is. The obtained CSP-1 output is directly fed to the CSP-2 filter. The purpose of CSP-2 is to linearly combine the output of the first spatial filter layer so that the maximum divergence can be obtained at the end of the output, Figure below describes the process of this method.

![image](https://user-images.githubusercontent.com/66156137/153705935-19ca088e-0549-472f-bf36-5b5d42504b6c.png)

**Classification **

The required input is the final result of the spatial filter, in this case, a training feature and testing feature which will then be adjusted to the label, namely the training label and test label. The data from the LDA classification will then be used as input to evaluate the performance in the performance calculation to find the accuracy, sensitivity, and specificity values. The Matlab function used to perform this classification is fitcdiscr which represents the classifier that I used in this study, namely Linear Discriminant Analysis (LDA). Previously the training data and test data were partitioned into 75% training data and 25% test data so that in terms of cross-validation this data was partitioned by 4 so that in 4-fold cross-validation, the original sample was randomly partitioned into 4 sub-samples of the same size. Of these k subsamples, one subsample is retained as validation data for model testing, and the remaining 3 subsamples as training data

**RESULTS AND DISCUSSION**

After obtaining the results of the EEG recording from the participants, the data can provide information about the desired brain wave activity. To obtain these results, it can be done by calculating the Power Spectral Density (PSD) so that it will produce Figure 5. In the picture mentioned above, information can be obtained that in this study the most dominant wave activity formed is the Mu wave (8-15 Hz). Then to eliminate information that is less essential in this study, a band pass Butterworth filter with cut-off (8 – 15) Hz will be used and obtain a signal as shown in Figure 6.

![image](https://user-images.githubusercontent.com/66156137/153705979-b757a25b-a7cc-40c2-be77-06e18d4379ec.png)

Figure 5 Power Spectral Density (PSD) from Dataset

After requiring the information through the PSD which is the feature, logarithm will be used of the variance for each channel. The log-var equation will extract the cell logarithmic feature and will generate a variable for each value from the trial. So it can be stated if the log-var value contains only one value feature for each component and if illustrated will produce Figure 7. To maximize the difference between "open class" and "relaxation class" the next step needed is to obtain the entire mixture channel by finding its maximum variance value and in this case, we will use the algorithm Common Spatial Pattern (CSP) and we will use CSP to calculate the mixture of channels designed to maximize the difference of variation by the two classes. mixture This can also be called a spatial filter. To calculate the value of CSP required a covariance matrix for each experiment. CSP will be defined in a Matlab function in which there is a command that distinguishes the two covariance values between the two classes so that we will get the log variance value a sin Figure 8. Shown to maximize the performance of this CSP, FBCSSP is used.

![image](https://user-images.githubusercontent.com/66156137/153706021-018426b8-73a9-4037-a1f0-662eed03f1d4.png)

Figure 6. Bandpass Frequency 8-15 Hz on two Channels

![image](https://user-images.githubusercontent.com/66156137/153706050-759cd6fe-c6a3-4f6e-84ca-1f69c0430bf5.png)

Figure 7. Logarithmic Variance for Each Components

![image](https://user-images.githubusercontent.com/66156137/153706093-c2f48646-2ad6-40f2-9ba9-a818e8c9d7a4.png)

Figure 8. Logarithmic Variance for Dataset after Spatial Filter

The input parameters used in this FBCSSP include several things which will be explained one by one. Params.bands is two column matrix, each row containing thefrequency cut off (Hz) (|f1, f2|) of the FIR filter in the filter bank. The number of rows (F) in this matrix is determined by the number of filters, so F = 7. Params.fs holds the sampling frequency (Hz) needed to make the FIR filter and the value corresponds to the data sampling frequency, which is 200 Hz. Params.P is the degree of FIR filters (P) determined by the algorithm, P value = 20. Params.m represents the number of spatial filters in each class for one CSP block (m) in the first CSP layer. Note that the number of classes is C, so a total of mx C x F spatial filters will be generated in the first CSP layer, given that m = 2. Params.r holds the number of spatial filters in each class for the second CSP layer. Therefore, the signal output from the FBCSSP should be rx C channels. FBCSSP.W1 is a cell array of matrix spatial filter for the first layer of CSP. W1 includes cell F and each cell contains a matrix of spatial filter size mx C x N. Where N is the number of channels. FBCSSP.W2 is a matrix for the second layer of CSP with size (rx C) x (mx C x F). The role of this matrix in the structure of FBCSSP is mainly frequency selection by giving weight to bands different frequency. FBCSSP.H is a cell array of filter coefficients for each FIR filter bank, the number of cells in the cell array is F and each cell contains an array with coefficient P. Then for feature extraction from this FBCSSP process, the value of feature train (ftr) and feature test (fts) as shown in Figure 9, which is the result of the log variance of the training signal that has undergone a spatial filter (ZTR) and a test signal that has undergone a spatial filter (ZTS) and will then be processed with the LDA classifier and produce Figure 10. 
 
![image](https://user-images.githubusercontent.com/66156137/153706101-d1db646a-3b07-4d3d-b0c8-ca73b76aaab6.png)

Figure 9. Feature Distribution
 
![image](https://user-images.githubusercontent.com/66156137/153706109-e99c1730-8e46-40b1-a799-75fd9b43b58d.png)
Figure 10. Feature after Classified by LDA

Performance evaluation results can be provided after undergoing data processing. The data are the results obtained from 2 classes of data, namely holding and opening the palm of the hand with an inmate and carried out three data retrieval experiments, so that the data is divided into dataset '1', dataset '2' and dataset '3'. In Table 1 shown that do cross validation with k = 4 or 4-fold. The table reports the accuracy values of each trial. Shown in every fold cross-validation this is done with the aim of minimizing the possibility of producing good performance just by chance [14]. This cross-validation can prove that the algorithm used is a robust algorithm and it can also be seen that the data set 1 to data set 3 has a mean accuracy of 83.33% to 87.50%. 

Through the data obtained from Table 1, the FBCSSP algorithm optimizes the spatial and spectral characteristics of the filter simultaneously so that it studies the training data given in the spatial and spectral domains. By imagining limb movement, attenuation of the EEG signal occurs in specific regions of the motor and somatosensory cortex due to loss of synchrony in the and bands, classically defined in 12-16 Hz and 18-24 Hz, respectively, which are termed desynchronization-related events (Fig. ERD) [15]. According to this statement, the spectral characteristics of the filter must have a bandpass in the μ and β frequency band. The frequency response of a trained FBCSSP network is calculated by feeding all inputs with a signal at a given frequency and measuring the average power at the output. In the spectral filter plot, the passband of the obtained spectral filter is approximately in the 8-16 Hz band, which is associated with the sensorimotor cortex [16]. Filters reveal similar characteristics with minimal differences. As stated for the spatial filter, there is a correlation between the performance of the subject classification and the suitability of the spectral filter with the given physiological facts, which is a testament to the effectiveness of this FBCSSP method.


**CONCLUSION**

Based on the results of the research on the classification of open class and relaxation of finger imagining movements from the EEG and EOG datasets obtained from the BNCI Horizon database with FBCSSP feature extraction and classifier, LDA can be concluded that the FBCSSP method is formed with a filter bank and two consecutive CSP layers in which the first CSP layer plays a role in localizing a specific spatial filter for a particular frequency band while the second gives weight to the frequency band and designs the spectral filter by linearly combining the outputs of the first layer. The results obtained from the proposed method are promising. The performance of this method can compete with other methods that we can find in the literature. This FBCSSP method produces a mean accuracy of classification after 4-fold cross validation of 86.10% which is the average of the three datasets. And the highest accuracy is obtained from dataset 3 of 87.50%. These results imply that the FBCSSP method is a method that can classify motor imagery with a simple, structured, non-iterative and fast-training.



**BIBLIOGRAPHY**

 
[1]	Soekadar, S. R. et al. (2015) ‘An EEG/EOG-based hybrid brain-neural computer interaction (BNCI) system to control an exoskeleton for the paralyzed hand’, Biomedizinische Technik, 60(3), pp. 199–205. doi: 10.1515/bmt-2014-0126.
[2]	Martin, A. et al. (2012) Dynamic Sling to Support Upper Extremity Post Brachial Plexus Injury to Return to Active Lifestyle.
[3]	Prieto, G. A. and Cano-de-la-cuerda, R. (2014) ‘Chapter 1 Emerging Perspectives in Stroke Rehabilitation’, (August). doi: 10.1007/978-3-642-38556-8.
[4]	Daniel, C. et al. (2019) Classification of Motor Imagery EEG Signals with CSP Filtering Through Neural Networks Models Classification of Motor Imagery EEG Signals with CSP Filtering Through Neural Networks Models. Springer International Publishing. doi: 10.1007/978-3-030-04491-6.
[5]	Kopowski, J. et al. (2019) ‘Bydgostian hand exoskeleton - Own concept and the biomedical factors’, Bio-Algorithms and Med-Systems, 15(1), pp. 1–7. doi: 10.1515/bams-2019-0003.
[6]	Li, M. et al. (2019) ‘An attention-controlled hand exoskeleton for the rehabilitation of finger extension and flexion using a rigid-soft combined mechanism’, Frontiers in Neurorobotics, 13(May), pp. 1–13. doi: 10.3389/fnbot.2019.00034.
[7]	Soekadar, S. R. et al. (2015) ‘An EEG/EOG-based hybrid brain-neural computer interaction (BNCI) system to control an exoskeleton for the paralyzed hand’, Biomedizinische Technik, 60(3), pp. 199–205. doi: 10.1515/bmt-2014-0126.
[8]	Aydemir, Ö. (2016) ‘Common spatial pattern-based feature extraction from the best time segment of BCI data’, Turkish Journal of Electrical Engineering and Computer Sciences, 24(5), pp. 3976–3986. doi: 10.3906/elk-1502-162.
[9]	Yuksel, A. and Olmez, T. (2015) ‘A Neural Network-Based Optimal Spatial Filter Design Method for Motor Imagery Classification’, pp. 1–21. doi: 10.1371/journal.pone.0125039.
[10]	Khorshidtalab, A., Salami, M. J. E. and Hamedi, M. (2012) ‘Evaluating the effectiveness of time-domain features for motor imagery movements using SVM’, 2012 International Conference on Computer and Communication Engineering, ICCCE 2012, (June 2014), pp. 909–913. doi: 10.1109/ICCCE.2012.6271348.
[11]	Hu, L. and Zhang, Z. (2019) EEG Signal Processing and Feature, Springer Nature Singapore Pte Ltd. 2019.
[12]	Wang, Y. and Gao, X. (2007) ‘Design of electrode layout for motor imagery based brain--computer interface imagery based brain – computer interface’, (September 2014), pp. 9–11. doi: 10.1049/el.
[13]	Samek, W. and Vidaurre, C. (2012) Stationary Common Spatial Patterns for Brain-Computer Interfacing.
[14] Seni, G. (2010) Ensemble Methods in Data Mining: Improving Accuracy Through Combining Predictions. SYNTHESIS LECTURES ONDATAMININGAND KNOWLEDGE DISCOVERY.
[15]	Tariq, M., Id, P. M. T. and Id, M. S. (2020) ‘and EEG classification of left-right foot dorsiflexion kinaesthetic motor imagery for’, pp. 1–20. doi: 10.1371/journal.pone.0230184.
[16]	Pfurtscheller, G. et al. (2006) ‘Mu rhythm ( de ) synchronization and EEG single-trial classification of different motor imagery tasks’, 31, pp. 153–159. doi: 10.1016/j.neuroimage.2005.12.003.






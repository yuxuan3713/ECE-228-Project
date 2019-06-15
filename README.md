# Audio  Feature  Extraction  And  Classification for  Urban  Sound
## ECE 228 Project SP19 Group 25


Please see requirement and link to dataset.
### Requirement
[Link to Requirement](Requirement.txt)

### Dataset
[Link to Dataset](Dataset.txt)

### Structure of this Repo
This repo contains matlab codes for the project.

#### Main ML demo code:
[Classfication on CNN](demo_CNN.m)

[Classfication on RNN(LSTM)](demo_LSTM.m)

[Classfication using SVM](demo_svm.m)

#### Data Pipelining
Some of the demo files contains utility of a dataStore object, which allows for file reading on demand in neural network training. There is a nozzle of feature selection in the object, namingly the reading function, which transform the data into desired feature and feeds them into the neural network.

Change of reading function is required if demostration of other features is desired.

#### Functions
There are various reading functions and utility functions available in the repo. Most of the requried functions are already linked across the files. As long as those files reside in the same folder, they should be able to refer to each other.

Examples are, neural network dataStore object reading function,
[FFT Reading Function](wav2fft3.m)

[MFCC Reading Function](wav2mfcc2.m)

[RMSE Reading Function](RMSE0603.m)

[Sequence Reading Function](wav2seq.m)

[Combo Readng Function](wav2comb.m)

and various sample utility functions,
[Feature Plots](Feature_Plots.ipynb) Plot vaious features.

[Random Split](randsplit.m) Randomly split a dataset into training set and test set.

[Delete Rare Classes](delete_rare_classes.m) Reform the dataset with 8 classes that have large count.

[Plot SVM result](plot_svm_result.m) Plot 3D graph for SVM grid search on hyperparameters.

[Repeat Padding](repeat_padding.m) Create repeating sample with desired length.

# Electrophysiology_recordings_analysis
Script for the analysis of electrophysiological recordings for neurobiological assays

**The aim of this script** is obtaining the quantitive data on the currents time decay and amplitude from electrophysiological recordings.

**Input data**

The recordings were obtained due to the patch-clamp technique in the whole-cell mode from hippocampal acute slices.
Recording is a timeline with current values. 
The current is the response to electrical stimulation according to the protocol: 1 stimulus -> 4 stimuli -> 5 stimul -> resistance check.

**Result**

The script upload and separate traces in recording. Then it shift traces to baseline calculated as signal mean from the trace begining to 490 ms. 
Further, the script create average traces for each stimuli type. To obtain transporter 5 current the subtraction of 4 stimuli from 5 stimuli is performed. 

<p align="center">
  <img src='https://github.com/Nosa1323/Electrophysiology-records-analysis/blob/main/figures/protocol.png?raw=true' width = "400">
</p>

Hereafter, it measure amplitude in transporter 1 and transporter 5 current. For decay time measurments an exponential fitting is applyed. 
Additionally, the script outputs a goodnes of fit score. 
<p align="center">
  <img src='https://github.com/Nosa1323/Electrophysiology-records-analysis/blob/main/figures/result.png?raw=true' width = "900">
</p>

# GTSRB Challenge

a.k.a German Traffic Sign Recognition Benchmark :de: :no_entry: :no_bicycles:
:no_entry_sign: ...

## Goal

Use [Torch](http://torch.ch/) to train and evaluate a 2-stage convolutional
neural network able to classify German traffic sign images (43 classes):

* fork the repository under your account,
* go to Settings > Features and enable Issues,
* create an issue under your repo describing your approach,
* report your result(s),
* commit your code,
* edit the README with pre-requisites and usage,
* boost accuracy by experimenting the multi-scale architecture,
* compare with the results obtained in matching mode (i.e use the features with a distance-based search).

## Repo

### Info
This repository has been forked from the Moodstocks/gtsrb repository. It contains the code used to approach the GTSRB challenge as suggest in "Goal" above.

### Execution
To execute this code,
* Download the GTSRB dataset using the "download.sh" script:
```bash
> ./download.sh
```
* Execute one of the "run-\*.lua" scripts using torch7. Please check the scripts to see the available options. Example:
```lua
> th run-cnnDropOut2.lua -save results-cnn-do2 -optimization SGD -learningRate 1e-3 -learningRateDecay 1e-7 -momentum 0.9 -plot
```

To test the results after a given iteration (here iteration 5), use the script "scripts/eval.lua" as follow:
```lua
> th scripts/eval.lua results-cnn-do2/hyp_epoch5.csv data/GT-final_test.csv
```

## Paper

[Traffic Sign Recognition with Multi-Scale Convolutional Networks](http://computer-vision-tjpn.googlecode.com/svn/trunk/documentation/reference_papers/2-sermanet-ijcnn-11-mscnn.pdf), by Yann LeCun et al.

## Dataset

### Training

`http://benchmark.ini.rub.de/Dataset/GTSRB_Final_Training_Images.zip` (263 MB)

### Testing

`http://benchmark.ini.rub.de/Dataset/GTSRB_Final_Test_Images.zip` (84 MB)
`http://benchmark.ini.rub.de/Dataset/GTSRB_Final_Test_GT.zip` (98 kB)

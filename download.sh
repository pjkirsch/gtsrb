#!/bin/bash

datadir="data"

mkdir -p $datadir

# Download datasets
wget -O $datadir/train.zip "http://benchmark.ini.rub.de/Dataset/GTSRB_Final_Training_Images.zip"
wget -O $datadir/test.zip "http://benchmark.ini.rub.de/Dataset/GTSRB_Final_Test_Images.zip"
wget -O $datadir/test_annot.zip "http://benchmark.ini.rub.de/Dataset/GTSRB_Final_Test_GT.zip"

# Unzip datasets
unzip -d $datadir $datadir/train.zip
unzip -d $datadir $datadir/test.zip
unzip -d $datadir $datadir/test_annot.zip

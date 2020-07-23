echo 'preprocess'
time ./bin/preprocess.sh &> log/preprocess.txt

echo 'train_nn'
time .bin/train_nn.sh &> log/train_nn.txt
echo 'make_cnn_feature'
time .bin/make_cnn_feature.sh &> log/make_cnn_feature.txt
echo 'train_simple_models'
time .bin/train_simple_models.sh &> log/train_simple_models.txt

echo 'stacking_lgbm'
time .bin/stacking_lgbm.sh &> log/stacking_lgbm.txt
echo 'stacking_svm'
time .bin/stacking_svm.sh &> log/stacking_svm.txt

echo 'blending_stacking'
time .bin/blending_stacking.sh &> log/blending_stacking.txt

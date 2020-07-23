
for is_train in true false; do
    if "${is_train}"; then
        warm_start=false
    else
        warm_start=true
    fi
    for i in 0 1 2 3 4
    do
    docker run --rm -it \
        -v $PWD/:/root/workdir/ \
        -v $HOME/.config/:/root/.config \
        -v $HOME/.netrc/:/root/.netrc \
        -v $HOME/.cache/:/root/.cache \
        -v $HOME/.git/:/root/.git \
        -e SLURM_LOCALID=0 \
        --shm-size=150gb \
        --runtime=nvidia \
        --ipc=host \
        --security-opt seccomp=unconfined \
        --network none \
        kaggle/pytorch:trends \
        python main_nn.py \
            base.opt_name=adam \
            data.n_fold=$i \
            data.is_train=$is_train \
            data.dataset_name=normal_dataset \
            data.use_pseudo_label=False \
            train.warm_start=$warm_start \
            train.learning_rate=0.001 \
            train.accumulation_steps=4 \
            train.refinement_step=8 \
            train.batch_size=16 \
            train.epoch=25 \
            store.model_name=simple_3dcnn \
            store.save_feature=True \
            model.backbone=None \
            model.model_name=simple_3dcnn \
            model.dropout_rate=0.2 \
            test.batch_size=8
    done
done

for is_train in true false; do
    if "${is_train}"; then
        warm_start=false
    else
        warm_start=true
    fi
    for i in 0 1 2 3 4
    do
    docker run --rm -it \
        -v $PWD/:/root/workdir/ \
        -v $HOME/.config/:/root/.config \
        -v $HOME/.netrc/:/root/.netrc \
        -v $HOME/.cache/:/root/.cache \
        -v $HOME/.git/:/root/.git \
        -e SLURM_LOCALID=0 \
        --shm-size=150gb \
        --runtime=nvidia \
        --ipc=host \
        --security-opt seccomp=unconfined \
        kaggle/pytorch:trends \
        python main_nn.py \
            base.opt_name=adam \
            data.n_fold=$i \
            data.is_train=$is_train \
            data.dataset_name=normal_dataset \
            data.use_pseudo_label=False \
            train.warm_start=$warm_start \
            train.learning_rate=0.001 \
            train.accumulation_steps=4 \
            train.refinement_step=8 \
            store.model_name=simple_3dcnn_3label \
            model.backbone=None \
            model.model_name=simple_3dcnn \
            model.dropout_rate=0.2 \
            train.batch_size=16 \
            train.epoch=25 \
            test.batch_size=8 \
            data.label_cols=[age,domain1_var1,domain1_var2] \
            data.weights=[0.3,0.175,0.175] \
            model.num_classes=3
    done
done
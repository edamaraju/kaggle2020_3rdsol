
docker run --rm -it \
    -v $PWD/:/root/workdir/ \
    -v $HOME/.config/:/root/.config \
    -v $HOME/.netrc/:/root/.netrc \
    -v $HOME/.cache/:/root/.cache \
    --shm-size=64gb \
    --runtime=nvidia \
    --ipc=host \
    --security-opt seccomp=unconfined \
    --network none \
    kaggle/pytorch:trends \
    python scripts/make_cnn_feature.py


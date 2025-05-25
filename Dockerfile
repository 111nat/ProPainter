# Используем базовый образ с CUDA 12.1
FROM nvidia/cuda:12.1.1-devel-ubuntu20.04

# Установим нужные утилиты
RUN apt-get update && apt-get install -y \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Miniconda
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
    && bash ~/miniconda.sh -b -p $CONDA_DIR \
    && rm ~/miniconda.sh

# Копируем environment.yaml в контейнер
COPY environment.yaml /tmp/environment.yaml

# Создаём окружение
RUN conda env create -f /tmp/environment.yaml

# Активируем окружение в PATH
ENV PATH /opt/conda/envs/propainter-gpu/bin:$PATH

# Копируем весь проект внутрь контейнера
COPY . /app
WORKDIR /app

# Делаем команду по умолчанию (можно изменить)
CMD ["python", "inference_propainter.py", "--video", "inputs/object_removal/bmx-trees", "--mask", "inputs/object_removal/bmx-trees_mask"]

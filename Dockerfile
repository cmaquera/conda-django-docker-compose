FROM continuumio/miniconda3

# Update enveroment dependencies:
RUN apt-get update -y --fix-missing
RUN apt-get install -y g++ make pkg-config libopencv-dev \
libgomp1 libffi7 netcat-openbsd gcc screen pandoc

# Create the environment:
COPY environment.yml .
RUN conda env create -f environment.yml

# Set project directory
WORKDIR /workspace

# Run a Jupyter notebook
ENTRYPOINT ["conda", "run", "-n", "notebook-prd", "jupyter", "notebook", "--ip=0.0.0.0", "--port=8080", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
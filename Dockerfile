# Pin base image
# See: https://hub.docker.com/r/continuumio/miniconda3
FROM continuumio/miniconda3@sha256:166ff37fba6c25fcad8516aa5481a2a8dfde11370f81b245c1e2e8002e68bcce
LABEL description="Base docker image with conda and util libraries"

# Install procps (so that Nextflow can poll CPU usage)
RUN apt-get update && \
    apt-get install -y procps && \
    apt-get clean -y

# Download the latest release tarball, unpack the tar file, and install
ARG VERSION=v2.3.2
WORKDIR /root
RUN wget https://github.com/PacificBiosciences/pb-CpG-tools/releases/download/${VERSION}/pb-CpG-tools-${VERSION}-x86_64-unknown-linux-gnu.tar.gz && \
    tar -xzf pb-CpG-tools-${VERSION}-x86_64-unknown-linux-gnu.tar.gz && \
    mv pb-CpG-tools-${VERSION}-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores /usr/local/bin

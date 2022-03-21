FROM google/cloud-sdk:377.0.0-alpine
LABEL maintainer="max.focker.shih@gmail.com"

ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV DATA_DIR "/pubsub-data"
ENV HOST_PORT 9000
ENV PUBSUB_PROJECT_ID test-pubsub

RUN apk --no-cache add openjdk8-jre

# Install the Pub/Sub emulator, then cleanup the (>400 MB) backup directory
RUN gcloud config set disable_usage_reporting true &&  \
    gcloud components install -q beta pubsub-emulator &&  \
    rm -rf /google-cloud-sdk/.install/.backup

# Create the directory to store Pub/Sub data
RUN mkdir -p "${DATA_DIR}"

# Expose the default emulator port
EXPOSE 9000

ADD start_emulator.sh /
RUN chmod +x /start_emulator.sh
CMD ["/start_emulator.sh"]
#Dockerfile to run Terraform with environment variables

FROM mcr.microsoft.com/azure-cli
COPY ./initscript.sh /
WORKDIR /
RUN chmod +x /initscript.sh
RUN sh -c ./initscript.sh

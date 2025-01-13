# docker, build, secret

docker image build -t IMAGE:latest --secret id=aws,src=$HOME/.aws/credentials .

## in dockerfile
# RUN --mount=type=secret,id=aws,target=/root/.aws/credentials make

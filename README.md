# Cloud One Application Security with Spring

- [Cloud One Application Security with Spring](#cloud-one-application-security-with-spring)
  - [Usage](#usage)
  - [Support](#support)
  - [Contribute](#contribute)

This demo app for Cloud One Application Security uses the PetClinic Example based on <https://docs.docker.com/language/java/build-images/>.

Application Security integration done via the provided Dockerfile

## Usage

First, clone the repo

Then build and run the container

```sh
# Build the image
DOCKER_BUILDKIT=1 docker build -t petclinic .

# Run the container
docker run --rm -p 8080:8080 --name petclinic petclinic
```

Demo Shellshock (ensure to have `Malicious Payload` enabled within the Application Security policy).

```sh
curl -H "User-Agent: () { :; }; /bin/eject" http://<IP>:8080/
```

## Support

This is an Open Source community project. Project contributors may be able to help, depending on their time and availability. Please be specific about what you're trying to do, your system, and steps to reproduce the problem.

For bug reports or feature requests, please [open an issue](../../issues). You are welcome to [contribute](#contribute).

Official support from Trend Micro is not available. Individual contributors may be Trend Micro employees, but are not official support.

## Contribute

I do accept contributions from the community. To submit changes:

1. Fork this repository.
1. Create a new feature branch.
1. Make your changes.
1. Submit a pull request with an explanation of your changes or additions.

I will review and work with you to release the code.

## Docker Setup (OS X)

### Traditional tools
The image is based on ubuntu and installs the tools needed below, for the ones that don't come by default.
- `cd tools/60-second-analysis && docker build -t ebf-analysis .`
- `docker run -it ebf-analysis bash`
- Run a sample command such as `sar -n UDP`

### BCC tools
**Vagrant**
This is the recommended route as it is relatively straightforward and works well.
- Install [Vagrant](https://www.vagrantup.com/downloads) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- Clone [this repo](https://github.com/OpeOnikute/vagrant-bcctools.git) and follow [the instructions](https://github.com/OpeOnikute/vagrant-bcctools#usage) to set up the Vagrant environment.

You can now experiment with any of the tools e.g. `execsnoop-bpfcc`!

**Docker**
My first attempt was with Docker for Mac, but it was a real hassle. Eventually got it working but some tools (such as `ext4slower`) kept failing. Leaving the docs here for anyone that wants to give it a shot in the future.
The setup was done with great help from [this blog post](https://petermalmgren.com/docker-mac-bpf-perf/).
- Go into the bcc tools folder. `cd tools/60-second-analysis/bcc-tools/docker`
- Get the Linux kit version in the container by running `uname -r`. Mine is `4.9.125-linuxkit`.
- Clone the linux kit to be mounted as a volume `git clone --depth 1 --branch v4.9.125 https://github.com/linuxkit/linux 4.9.125-linuxkit`. Since it's heavy, add the folder name (e.g. 4.9.125-linuxkit) to the dockerignore so it's not added to builds.
- Build the image `docker build -t docker-bpf .`
- ```
docker run -it --rm \
  --privileged \
  -v "$(pwd)/4.9.125-linuxkit:/lib/modules/4.9.125-linuxkit/source" \
  -v "$(pwd)/4.9.125-linuxkit:/lib/modules/4.9.125-linuxkit/build" \
  -v "$(pwd)/4.9.125-linuxkit:/usr/src/4.9.125-linuxkit" \
  --workdir /usr/share/bcc/tools \
  docker-bpf
```

## Tools
- [Traditional tools](/tools/60-second-analysis/traditional-tools/README.md)
- [BCC tools](/tools/60-second-analysis/bcc-tools/README.md)
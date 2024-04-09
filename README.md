Minimal shell develop environment installation for iplee.

This project provide a simple, one-step way to install shell dev env. This is useful for docker container. By running this once, you can have greet shell dev env for development.

This project depends on `.iplee-conf` and `.iplee-exe`. This a trade-off. Ideally, this project should not depend on another project, but since `.iplee-conf` and `.iplee-exe` have saved a lot of configs I am using, this project should depend on them.

But for better dependence management, this project includes a `depend.yaml` file, to index the commit-hash/repo-url of the dependency and some other configs.

This installation only supports linux for now (i.e. only sync with linux-port from .iplee-conf).

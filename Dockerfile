FROM sameersbn/gitlab-ci-runner:latest
MAINTAINER Tomasz Maczukin "tomasz@maczukin.pl"

ENV DEBIAN_FRONTEND noninteractive
RUN echo "APT::Install-Recommends 0;" >> /etc/apt/apt.conf.d/01norecommends && \
        echo "APT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends

RUN apt-get update # update_20150710113414
RUN apt-get upgrade -y
RUN apt-get install -y git-core build-essential \
                        zlib1g-dev libssl-dev libreadline-dev libyaml-dev \
                        libxml2-dev libxslt-dev libffi-dev && \
                        apt-get clean

USER gitlab_ci_runner
WORKDIR /home/gitlab_ci_runner
ENV HOME /home/gitlab_ci_runner
ENV CONFIGURE_OPTS --disable-install-doc

RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

RUN echo "export PATH=\"\$HOME/.rbenv/bin:\$PATH\"" >> ~/.profile
RUN echo "eval \"\$(rbenv init -)\"" >> ~/.profile
RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

RUN . ~/.profile; rbenv install 2.2.0
RUN . ~/.profile; rbenv global 2.2.0
RUN . ~/.profile; gem install bundler

USER root

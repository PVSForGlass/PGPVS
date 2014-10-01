FROM mjdsys/debian

MAINTAINER Matthew Dawson <matthew@mjdsystems.ca>

RUN apt-get update && apt-get install --no-install-recommends -y locales emacs sbcl netbase autoconf build-essential && rm /var/lib/apt/lists/* -rf

RUN echo en_CA.UTF-8 UTF-8 >/etc/locale.gen
RUN locale-gen

ENV LANG en_CA.utf8

RUN mkdir /app
ADD sbcl /app/sbcl
ADD pvs /app/pvs

RUN cd /app/sbcl && echo '"1.2.3"' > version.lisp-expr && bash make.sh && \
	cd /app/pvs && autoconf && ./configure && SBCLISP_HOME=/app/sbcl make && \
	rm /app/sbcl /app/pvs/{pvs,emacs,BDD,ess,doc,python,TAGS,eclipse,javascript} -rf

FROM alpine:edge
MAINTAINER dmitry.leonenko@gmail.com
RUN apk update \
	&& apk add llvm gcc binutils musl-dev clang make pcre-dev libpcap-dev git \
	&& git clone https://github.com/kontaxis/snidump.git \
	&& cd snidump \
	&& clang -O3 -flto -D__DEBUG__=0 -Wall src/snidump.c src/tls.c src/http.c -o /usr/bin/snidump -static -lpcap -lpcre \
	&& cd .. \
	&& rm -rf snidump \
	&& apk del llvm gcc binutils musl-dev clang make pcre-dev libpcap-dev git \
	&& rm -rf /tmp/* /var/tmp/* /var/cache/apk/*
ENTRYPOINT [ "/usr/bin/snidump" ]

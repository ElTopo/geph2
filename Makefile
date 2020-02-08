GO=go
GOBUILDFLAG = -x -v

all: client bridge binder exit

remake: 
	 $(GO) build $(GOBUILDFLAG) -a ./cmd/geph-client/
	 $(GO) build $(GOBUILDFLAG) -a ./cmd/geph-bridge/
	 $(GO) build $(GOBUILDFLAG) -a ./cmd/geph-binder/
	 $(GO) build $(GOBUILDFLAG) -a ./cmd/geph-exit/

client: geph-client
	$(GO) build $(GOBUILDFLAG) -o $< ./cmd/geph-client/

bridge: geph-bridge
	$(GO) build $(GOBUILDFLAG) -o $< ./cmd/geph-bridge/

binder: geph-binder
	$(GO) build $(GOBUILDFLAG) -o $< ./cmd/geph-binder/

exit: geph-exit
	$(GO) build $(GOBUILDFLAG) -o $< ./cmd/geph-exit/


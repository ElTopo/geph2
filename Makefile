GO=go
GOBUILDFLAG = -v

all: geph-client geph-bridge geph-binder geph-exit

remake: 
	 $(GO) build $(GOBUILDFLAG) -a ./cmd/geph-client/
	 $(GO) build $(GOBUILDFLAG) -a ./cmd/geph-bridge/
	 $(GO) build $(GOBUILDFLAG) -a ./cmd/geph-binder/
	 $(GO) build $(GOBUILDFLAG) -a ./cmd/geph-exit/

geph-client: $(wildcard ./cmd/geph-client/*.go)
	$(GO) build $(GOBUILDFLAG) -o $@ ./cmd/geph-client/

geph-bridge: $(wildcard ./cmd/geph-bridge/*.go)
	$(GO) build $(GOBUILDFLAG) -o $@ ./cmd/geph-bridge/

geph-binder: $(wildcard ./cmd/geph-binder/*.go)
	$(GO) build $(GOBUILDFLAG) -o $@ ./cmd/geph-binder/

geph-exit: $(wildcard ./cmd/geph-exit/*.go)
	$(GO) build $(GOBUILDFLAG) -o $@ ./cmd/geph-exit/


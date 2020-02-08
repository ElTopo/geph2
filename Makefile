GO=go
GOBUILDFLAG = -v
GOBUILD = $(GO) build $(GOBUILDFLAG)

all: geph-client geph-bridge geph-binder geph-exit

remake: 
	 $(GOBUILD) -a ./cmd/geph-client/
	 $(GOBUILD) -a ./cmd/geph-bridge/
	 $(GOBUILD) -a ./cmd/geph-binder/
	 $(GOBUILD) -a ./cmd/geph-exit/

geph-client: $(wildcard ./cmd/geph-client/*.go)
	$(GOBUILD) -o $@ ./cmd/geph-client/

geph-bridge: $(wildcard ./cmd/geph-bridge/*.go)
	$(GOBUILD) -o $@ ./cmd/geph-bridge/

geph-binder: $(wildcard ./cmd/geph-binder/*.go)
	$(GOBUILD) -o $@ ./cmd/geph-binder/

geph-exit: $(wildcard ./cmd/geph-exit/*.go)
	$(GOBUILD) -o $@ ./cmd/geph-exit/


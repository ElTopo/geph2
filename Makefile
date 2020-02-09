GO=go
GOBUILDFLAG = -v
GOBUILD = $(GO) build $(GOBUILDFLAG)
GOFMT = gofmt

all: geph-client geph-bridge geph-binder geph-exit

geph-client: $(wildcard ./cmd/geph-client/*.go)
	$(GOBUILD) -o $@ ./cmd/geph-client/

geph-bridge: $(wildcard ./cmd/geph-bridge/*.go)
	-$(GOBUILD) -o $@ ./cmd/geph-bridge/

geph-binder: $(wildcard ./cmd/geph-binder/*.go)
	-$(GOBUILD) -o $@ ./cmd/geph-binder/

geph-exit: $(wildcard ./cmd/geph-exit/*.go)
	-$(GOBUILD) -o $@ ./cmd/geph-exit/

# other tools
fresh:
	rm -f geph-client geph-bridge geph-binder geph-exit
	$(MAKE) all

rebuild:
	$(GOBUILD) -a -o geph-client ./cmd/geph-client/
	-$(GOBUILD) -a -o geph-bridge ./cmd/geph-bridge/
	-$(GOBUILD) -a -o geph-binder ./cmd/geph-binder/
	-$(GOBUILD) -a -o geph-exit ./cmd/geph-exit/

chkfmt:
	@$(GOFMT) -l $(wildcard ./cmd/geph-client/*.go)
	@$(GOFMT) -l $(wildcard ./cmd/geph-bridge/*.go)
	@$(GOFMT) -l $(wildcard ./cmd/geph-binder/*.go)
	@$(GOFMT) -l $(wildcard ./cmd/geph-exit/*.go)

fmt:
	@$(GOFMT) -w $(wildcard ./cmd/geph-client/*.go)
	@$(GOFMT) -w $(wildcard ./cmd/geph-bridge/*.go)
	@$(GOFMT) -w $(wildcard ./cmd/geph-binder/*.go)
	@$(GOFMT) -w $(wildcard ./cmd/geph-exit/*.go)


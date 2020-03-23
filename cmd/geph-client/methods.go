package main

import (
	"errors"
	"net"
	"strings"
	"sync"
	"time"

	"github.com/ethereum/go-ethereum/rlp"
	"github.com/geph-official/geph2/libs/bdclient"
	"github.com/geph-official/geph2/libs/niaucchi4"
)

func getSingleTCP(bridges []bdclient.BridgeInfo) (conn net.Conn, err error) {
	bridgeRace := make(chan net.Conn)
	bridgeDeadWait := new(sync.WaitGroup)
	bridgeDeadWait.Add(len(bridges))
	go func() {
		bridgeDeadWait.Wait()
		close(bridgeRace)
	}()
	syncer := make(chan bool)
	go func() {
		time.Sleep(time.Second * 2)
		close(syncer)
	}()
	for _, bi := range bridges {
		bi := bi
		go func() {
			defer bridgeDeadWait.Done()
			bridgeConn, err := dialBridge(bi.Host, bi.Cookie)
			if err != nil {
				//log.Debugln("dialing to", bi.Host, "failed!", err)
				return
			}
			bridgeConn.SetDeadline(time.Now().Add(time.Second * 30))
			rlp.Encode(bridgeConn, "conn/feedback")
			rlp.Encode(bridgeConn, exitName)
			_, err = bridgeConn.Read(make([]byte, 1))
			if err != nil {
				bridgeConn.Close()
				//log.Debugln("conn in", bi.Host, "failed!", err)
				return
			}
			select {
			case bridgeRace <- bridgeConn:
			default:
				bridgeConn.Close()
			}
		}()
	}
	zz, ok := <-bridgeRace
	if !ok {
		err = errors.New("singlepath timed out")
		return
	}
	useStats(func(sc *stats) {
		sc.bridgeThunk = func() []niaucchi4.LinkInfo {
			sessions := make([]niaucchi4.LinkInfo, 1)
			sessions[0].RemoteIP = strings.Split(zz.RemoteAddr().String(), ":")[0]
			sessions[0].RecvCnt = -1
			return sessions
		}
	})
	conn = zz
	return
}

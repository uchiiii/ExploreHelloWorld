package main

import (
	"fmt"
	"net/http"
	"sync"
)

func wait() {
	fmt.Println("waiting")
}

func main() {
	var wg sync.WaitGroup

	for i := 0; i < 100; i++ {
		wg.Add(1)

		go func() {
			http.Get(`https://httpstat.us/200?sleep=10000`)

			fmt.Println("OK")
			wg.Done()
		}()
	}

	wait()
	wg.Wait()
}

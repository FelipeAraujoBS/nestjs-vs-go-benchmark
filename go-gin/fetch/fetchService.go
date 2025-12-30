package fetch

import (
	"encoding/json"
	"io"
	"net/http"
	"sync"
	"fmt"
)

type FetchService struct{}

func NewFetchService() *FetchService{
	return &FetchService{}
}

func (s *FetchService) FetchPost() ([]map[string]interface{}, error){
	resp, err := http.Get("https://jsonplaceholder.typicode.com/posts")
	if err != nil {
		return nil, err
	}

	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	var posts []map[string]interface{}
	err = json.Unmarshal(body, &posts)
	if err != nil {
		return nil, err
	}

	return posts, nil
}

func (s *FetchService) AggregateData() ([]map[string]interface{}, error) {
    var wg sync.WaitGroup
    results := make([]map[string]interface{}, 10)
    errors := make([]error, 10)

    for i := 0; i < 10; i++ {
        wg.Add(1)
        go func(index int) {
            defer wg.Done()
            
            url := fmt.Sprintf("https://jsonplaceholder.typicode.com/posts/%d", index+1)
            resp, err := http.Get(url)
            if err != nil {
                errors[index] = err
                return
            }
            defer resp.Body.Close()  // ✅ Body maiúsculo

            body, err := io.ReadAll(resp.Body)  // ✅ Body maiúsculo
            if err != nil {
                errors[index] = err
                return
            }

            var post map[string]interface{}
            err = json.Unmarshal(body, &post)
            if err != nil {
                errors[index] = err
                return
            }

            results[index] = post
        }(i)
    }

    wg.Wait()

    for _, err := range errors {
        if err != nil {
            return nil, err
        }
    }

    return results, nil
}

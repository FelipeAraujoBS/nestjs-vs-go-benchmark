package primes

type Service struct{}

func NewService() *Service {
    return &Service{}
}

func (s *Service) Calculate(n int) []int {
    if n < 2 {
        return []int{}
    }
    
    primes := make([]int, 0, n/10)
    
    primes = append(primes, 2)
    
    for i := 3; i <= n; i += 2 {
        isPrime := true
        
        for j := 3; j*j <= i; j += 2 {
            if i%j == 0 {
                isPrime = false
                break
            }
        }
        
        if isPrime {
            primes = append(primes, i)
        }
    }
    
    return primes
}
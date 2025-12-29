import { Injectable } from '@nestjs/common';

@Injectable()
export class PrimesService {
  calculatePrime(n: number): number[] {
    const primes: number[] = [];

    for (let i = 2; i <= n; i++) {
      let isPrime = true;
      for (let j = 2; j * j <= i; j++) {
        if (i % j === 0) {
          isPrime = false;
          break;
        }
      }
      if (isPrime) primes.push(i);
    }

    return primes;
  }
}
